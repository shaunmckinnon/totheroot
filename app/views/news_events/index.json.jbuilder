json.array!(@news_events) do |news_event|
  json.extract! news_event, :id, :heading, :synopsis, :article, :tags, :publish_date
  json.url news_event_url(news_event, format: :json)
end
