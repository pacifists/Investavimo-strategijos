json.extract! stock_info, :id, :stock_id, :stock_date, :open, :high, :low, :close, :adj_close, :volume, :created_at, :updated_at
json.url stock_info_url(stock_info, format: :json)
