json.array!(@payments) do |payment|
  json.extract! payment, :id, :user_id, :price, :state, :pending_at, :completed_at, :canceled_at, :paid_at, :trade_no, :note
  json.url payment_url(payment, format: :json)
end
