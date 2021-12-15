Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'big.wtf', 'dashboard.big.wtf', '127.0.0.1:8080', 'localhost:8080'
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
