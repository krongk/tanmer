json.array!(@page_rates) do |page_rate|
  json.extract! page_rate, :id, :page_id, :member_id, :rate_count
  json.url page_rate_url(page_rate, format: :json)
end
