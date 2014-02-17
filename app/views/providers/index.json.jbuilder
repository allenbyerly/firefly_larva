json.array!(@providers) do |provider|
  json.extract! provider, :id, :pname, :location, :price, :copay
  json.url provider_url(provider, format: :json)
end
