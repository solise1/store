# Based on rack/contrib/locale
module Locale
  extend ActiveSupport::Concern

  def switch_locale(&action)
    locale = user_preferred_locale(request.env["HTTP_ACCEPT_LANGUAGE"])
    locale ||= I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  private

  def user_preferred_locale(header)
    locales = parse_locales(header)

    return if locales.empty?

    locale = locales.reverse.find { |l| I18n.available_locales.any? { |al| l.casecmp?(al.to_s) } }

    locale ||= I18n.available_locales.find { |al| locales.reverse.find { |l| l[..1].casecmp?(al.to_s) } }
  end

  def parse_locales(header)
    return unless header

    header_locales = header.gsub(/\s+/, "").split(",").map do |language_tag|
      locale, quality = language_tag.split(/;q=/i)
      quality = quality ? quality.to_f : 1.0
      [ locale, quality ]
    end

    header_locales
      .reject { |locale, quality| locale == "*" || quality == 0 }
      .sort_by { |_, quality| quality }
      .map { |locale, _| locale }
  end
end
