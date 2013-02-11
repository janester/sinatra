require "pry"
require "sinatra"
require "sinatra/reloader" if development?

# get "/name/:first/:last/:age" do
#   "Your name is: #{params[:first]} #{params[:last]} #{params[:age]}"
#   # "Your age is: #{params[:age]}"
# end

# get "/hello" do
#   "I am a master hacker ninja!!!"
# end

# get "/" do
#   "this is the homepage"
# end

# get "/jane" do
#   "Jane Sternbach"
# end

# get "/calc/multiply/:first/:second" do
#   @answer = params[:first].to_f*params[:second].to_f
#   # "#{params[:first]} times #{params[:second]} is #{answer}"
#   erb :calc
# end

# get "/calc/add/:first/:second" do
#   @answer = params[:first].to_f + params[:second].to_f
#   erb :calc
# end

get "/calc" do
  @first = params[:first].to_f
  @second = params[:second].to_f

  @answer = case params[:operator]
  when "+" then @first + @second
  when "-" then @first - @second
  when "*" then @first * @second
  when "/" then @first / @second
  end
  @answer = @answer
  erb :calc
end