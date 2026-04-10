module Paginable
  extend ActiveSupport::Concern

  def paginate(collection, per_page)
    @count = collection.count
    @page = params[:page].to_i || 1

    offset = (@page - 1) * per_page

    collection.limit(per_page).offset(offset)
  end
end
