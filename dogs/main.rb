require "pry"
require "sinatra"
require "sinatra/reloader" if development?
require "active_support/all"
require "pg"

before do
  sql = "select distinct breed from dogs"
  conn = PG.connect(:dbname =>'dog_db', :host => 'localhost')
  @nav_rows = conn.exec(sql)
  conn.close
end

get "/" do
  erb :home
end

get '/all/:id/edit' do
  sql = "select * from dogs where id = '#{params["id"]}'"
  conn = PG.connect(:dbname =>'dog_db', :host => 'localhost')
  rows = conn.exec(sql)
  @row = rows.first
  conn.close
  erb :new
end

post "/all/:id/delete" do
  sql = "delete from dogs where id = '#{params["id"]}'"
  conn = PG.connect(:dbname =>'dog_db', :host => 'localhost')
  conn.exec(sql)
  conn.close
  redirect to "/all"
end

post "/all/:id" do
  sql = "update dogs set name='#{params["name"]}', photo='#{params["photo"]}', breed='#{params["breed"]}' where id = '#{params["id"]}'"
  conn = PG.connect(:dbname =>'dog_db', :host => 'localhost')
  conn.exec(sql)
  conn.close
  redirect to "/all"
end

get "/new" do
  erb :new
end

get "/all" do
  sql = "select * from dogs"
  conn = PG.connect(:dbname =>'dog_db', :host => 'localhost')
  @rows = conn.exec(sql)
  conn.close
  erb :all
end

get "/all/:breed" do
  sql = "select * from dogs where breed = '#{params[:breed]}'"
  conn = PG.connect(:dbname =>'dog_db', :host => 'localhost')
  @rows = conn.exec(sql)
  conn.close
  erb :all
end




post "/create" do
  @name = params[:name]
  @photo = params[:photo]
  @breed = params[:breed]
  sql = "insert into dogs (name, photo, breed) values ('#{@name}', '#{@photo}', '#{@breed}')"
  conn = PG.connect(:dbname =>'dog_db', :host => 'localhost')
  conn.exec(sql)
  conn.close
  redirect to "/all"
end
