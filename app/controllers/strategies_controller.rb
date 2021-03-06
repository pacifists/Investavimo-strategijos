require 'csv'
class StrategiesController < ApplicationController
  def timing(date=nil)
  	# What indices we are interested in except BND (20%)
  	indices = {"SPY" => 10, "VEA" => 10, "VWO" => 20, "VNQ" => 20, "GSG" => 10, "GLD" => 10}
  	client = Alphavantage::Client.new key: "JYYA2YXZH1MGGLP8"
  	@stocks = []
  	@target_date = "2017-11-30"
  	indices.each do |idx, percent|
  		cache_key = "#{idx}-#{@target_date}"
			stock = client.stock symbol: idx, datatype: "csv"
	  	indicator_file = Rails.root.join("tmp", "cache", "#{cache_key}_indicator.json")
	  	if File.exists?(indicator_file)
	  		# read from file
				ind_hash = JSON.parse(File.read(indicator_file))
	  	else
	  		indicator = stock.indicator(function: "SMA", interval: "monthly", time_period: "12", series_type: "close")
		  	# sma = indicator.hash["Technical Analysis: SMA"][0..2]
		  	File.open(indicator_file,"w") do |f|
		  	  f.write(indicator.hash.to_json)
		  	end
		  	ind_hash = indicator.hash
	  	end
	  	tseries_file = Rails.root.join("tmp", "cache", "#{cache_key}-tseries.csv")
	  	if File.exists?(tseries_file)
	  		# tseries = 
	  	else
	  		stock.timeseries(type: "daily", outputsize: "compact", datatype: "csv", file: tseries_file)
	  	end
	  	csv_text = File.read(tseries_file)
	  	csv = CSV.parse(csv_text, :headers => true)
	  	stock_series = []
	  	csv.each do |row|
	  	  stock_series << row.to_hash
	  	end

	  	data = {
	  		:stock => idx,
	  		:percent => percent,
	  		:sma => ind_hash,
	  		:tseries => stock_series
	  	}
  	
	  	@stocks << data
		end
  end

  def momentum
  	# we buy 3 positions out of 8 (7 etfs and cash it has momentum 1 all the time)
  	# we pick the ones that have biggest inertion
  	# inertion is price now compared to price 1, 3, 6, 9, 12 months ago
  	# then we rate from biggest to lowest and take first 3
  	unless params[:date].blank?
	  	stocks = Stock.where(:stock_type => 'stock').all
	  	@target_date = Date.parse(params[:date])
	  	best_stocks = {0 => {:momentum => 5, :name => 'CASH'}}
	  	stocks.each do |s|
	  		best_stocks[s.id] = {:momentum => s.get_stock_momentum(@target_date), :name => s.name}
	  	end
	  	@sorted_data = best_stocks.sort_by {|k, v| v[:momentum]}.reverse
	  end

  end
end
