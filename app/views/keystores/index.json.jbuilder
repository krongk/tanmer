json.array!(@keystores) do |keystore|
  json.extract! keystore, :id, :user_id, :key, :value
  json.url keystore_url(keystore, format: :json)
end
