json.array!(@routes) do |route|
  json.extract! route, :id, :to_id, :from_id, :priority, :provider, :frequency
end
