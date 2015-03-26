json.array!(@image_items) do |image_item|
  json.extract! image_item, :id
  json.url image_item_url(image_item, format: :json)
end
