json.array!(@pages) do |page|
  json.extract! page, :id, :user_id, :title, :keywords, :description, :content, :qrcode, :short_title, :properties, :amount, :price, :view_count, :fav_count, :is_processed
  json.url page_url(page, format: :json)
end
