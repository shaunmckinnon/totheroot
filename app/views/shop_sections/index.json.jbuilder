json.array!(@shop_sections) do |shop_section|
  json.extract! shop_section, :id, :name, :description
  json.url shop_section_url(shop_section, format: :json)
end
