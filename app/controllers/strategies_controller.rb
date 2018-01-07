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
  	# vieno menesio laikotarpiui perkam ir laikom 3 pozicijas inertiškiausias
  	# inertiškumas tai kaina dabar / kainos prieš 12 mėnesių
  	# tada sureitinguojam koks gaunasi santykis. 3 didžiausius perkam, kitus parduodam
  end
end
