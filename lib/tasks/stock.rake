namespace :stock do
  desc "Gets all stocks and downloads/updates daily info for them"
  task update_info: :environment do
  	# create empty tasks so that we can accept arguments for the method
  	ARGV.each { |a| task a.to_sym do ; end }

  	outputsize = "compact"
  	if (!ARGV[1].blank? && ARGV[1] == "full")
  		outputsize = "full"
  	end

  	stocks = Stock.where({:stock_type => 'stock'}).all
  	client = Alphavantage::Client.new key: "JYYA2YXZH1MGGLP8"

  	stocks.each do |stock|
  		# if it was refreshed today, skip it
  		# this way we can rerun if there's an API error
  		if stock.last_refreshed == Date.current
  			next
  		end

  		s = client.stock symbol: stock.name, datatype: "json"
  		data = s.timeseries(type: "daily", outputsize: outputsize, adjusted: true)
  		data.hash["Time Series (Daily)"].each do |index, value|
  			info = {
  				:stock_date => index,
  				:open => value["1. open"],
  				:high => value["2. high"],
  				:low => value["3. low"],
  				:close => value["4. close"],
  				:adj_close => value["5. adjusted close"],
  				:volume => value["6. volume"]
  			}
  			unless stock.stock_infos.exists?(:stock_date => index)
  				stock.stock_infos.create(info)	
  			end
  			
  		end
  		# update stock last_refreshed with current date
  		stock.update_attribute(:last_refreshed, Date.current)
  	end
  end

end
