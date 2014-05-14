json.array!(@payment_notifies) do |payment_notify|
  json.extract! payment_notify, :id, :payment_id, :payment_number, :payment_count, :state, :cate, :status
  json.url payment_notify_url(payment_notify, format: :json)
end
