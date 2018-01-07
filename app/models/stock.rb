class Stock < ApplicationRecord
	has_many :stock_infos

	def get_stock_momentum(target_date=Date.current)
		# I need to calculate the stock momentum for 1, 3, 6, 9, 12 months
		# and return the total sum of momentums for that period
		calculate_momentums = [1, 3, 6, 9, 12]
		total_momentum = 0
		calculate_momentums.each do |i|
			total_momentum += self.get_stock_price_inertion(target_date, i)
		end
		return total_momentum.round(4)
	end

	# we get the price inertion for given amount of months back from target date
	def get_stock_price_inertion(target_date, months_ago)
		# will need to figure out the latest date that matches 
		# "end of month" definition or just a month ago
		last_price = self.stock_infos.where("stock_date <= ?", target_date).order(:stock_date => :desc).first
		search_date = (target_date - months_ago.month).end_of_month
		old_price = self.stock_infos.where("stock_date <= ?", search_date).order(:stock_date => :desc).first
		result = last_price.adj_close.to_f / old_price.adj_close.to_f
		return result.round(4)
	end

end
