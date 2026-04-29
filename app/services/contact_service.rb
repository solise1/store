class ContactService
  def initialize(args)
    @badwords = CSV.read("#{Rails.root}/config/badwords.csv").flatten.to_set
    @subject = sanitize args[:subject]
    @body = sanitize args[:body]
    @email = args[:email]
  end

  def mail
    ContactMailer.contact({
      subject: @subject,
      body: @body,
      email: @email
    }).deliver_later
  end

  def sanitize(input)
    input.lines(chomp: true).reject(&:empty?).map do |line|
      line.split.map do |word|
        @badwords.include?(word.downcase.tr("^a-z", "")) ? "[removed]" : word
      end.join(" ")
    end.join("\n")
  end
end
