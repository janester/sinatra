require "pry"
require "sinatra"
require "sinatra/reloader" if development?
require "yahoofinance"

get "/stock" do
  if !params[:stock_sym].nil?
    name = params[:stock_sym].upcase
    @quote = YahooFinance::get_quotes(YahooFinance::StandardQuote, name)[name].lastTrade
  end
  erb :stock
end
