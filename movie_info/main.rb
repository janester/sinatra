require "pry"
require "sinatra"
require "sinatra/reloader" if development?
require "HTTParty"
require "JSON"
require "pg"

get "/" do
  erb :home
end

get "/about" do
  erb :about
end

get "/faq" do
  erb :faq
end

get "/movies" do
  sql = "select poster from movies"
  conn = PG.connect(:dbname =>'movie_app', :host => 'localhost')
  @rows = conn.exec(sql)
  conn.close
  erb :movies
end

get "/results" do
  movie = params[:movie]
  movie = movie.split.join("+")
  info = HTTParty.get("http://www.omdbapi.com/?i=&t=#{movie}")
  info = JSON(info)
  @poster = info["Poster"]
  @title = info["Title"]
  @year = info["Year"]
  @rated = info["Rated"]
  @released = info["Released"]
  @runtime = info["Runtime"]
  @genre = info["Genre"]
  @director = info["Director"]
  @writer = info["Writer"]
  @actors = info["Actors"]
  @plot = info["Plot"].split("'").join()
  @rt_name= @title.split.join("_").split("-").join("_").split("'").join().downcase.split(":").join()

  sql = "insert into movies (title, year, rated, released, runtime, genre, director, writers, actors, plot, poster) values ('#{@title}', '#{@year}', '#{@rated}', '#{@released}', '#{@runtime}', '#{@genre}', '#{@director}', '#{@writer}', '#{@actors}', '#{@plot}', '#{@poster}')"


  conn = PG.connect(:dbname =>'movie_app', :host => 'localhost')
  conn.exec(sql)

  conn.close
  erb :results
end
