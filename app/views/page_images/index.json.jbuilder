json.array!(@page_images) do |page_image|
  json.extract! page_image, :id, :page_id, :image
  json.url page_image_url(page_image, format: :json)
end
