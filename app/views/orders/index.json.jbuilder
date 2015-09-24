json.array!(@orders) do |order|
  json.extract! order, :id, :customer, :shipping_address, :email, :phone, :total
  json.url order_url(order, format: :json)
end
