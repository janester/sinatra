require "pry"
require "sinatra"
require "sinatra/reloader" if development?
require "active_support/all"
require "pg"

before do
  sql = "select distinct genre from videos"
  conn = PG.connect(:dbname =>'vid_db', :host => 'localhost')
  @nav_rows = conn.exec(sql)
  conn.close
end

get "/" do
  erb :home
end

get "/new" do
  erb :new
end

get "/all/:genre" do
  sql = "select * from videos where genre = '#{params[:genre]}'"
  @rows = run_sql(sql)
  erb :all
end


get '/all/:id/edit' do
  sql = "select * from videos where id = '#{params["id"]}'"
  rows = run_sql(sql)
  @row = rows.first
  erb :new
end

post "/all/:id" do
  sql = "update videos set name='#{params["name"]}', description='#{params["description"]}', url='#{params["url"]}', genre='#{params["genre"]}' where id = '#{params["id"]}'"
  run_sql(sql)
  redirect to "/all"
end

post "/create" do
  @name = params[:name].titleize
  @description = params[:description]
  @url = params[:url]
  @genre = params[:genre].titleize
  sql = "insert into videos (name, description, url, genre) values ('#{@name}', '#{@description}', '#{@url}', '#{@genre}')"
  run_sql(sql)
  redirect to "/all"
end

post "/all/:id/delete" do
  sql = "delete from videos where id = '#{params["id"]}'"
  run_sql(sql)
  redirect to "/all"
end

get "/all" do
  sql = "select * from videos"
  conn = PG.connect(:dbname =>'vid_db', :host => 'localhost')
  @rows = conn.exec(sql)
  conn.close
  erb :all
end


def run_sql(sql)
  conn = PG.connect(:dbname =>'vid_db', :host => 'localhost')
  result = conn.exec(sql)
  conn.close

  result
end