class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks
  validates :name, :ticker, presence: true
  
	def self.new_lookup(ticker_symbol)			
	  begin
	    stock = StockQuote::Stock.quote(ticker_symbol)
		new(ticker: stock.symbol, name: stock.company_name, last_price: stock.latest_price)
	  rescue => exception
		return nil
	  end
		
	end

	def self.check_db(ticker_symbol)
		where(ticker: ticker_symbol.upcase).first
	end
end
