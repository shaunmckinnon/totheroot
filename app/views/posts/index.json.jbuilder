json.array!(@posts) do |post|
  json.extract! post, :id, :category_id, :name, :synopsis, :content, :description
  json.url post_url(post, format: :json)
end
