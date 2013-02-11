require "pry"
require "sinatra"
require "sinatra/reloader" if development?
require "pg"

get "/" do
  sql = "select * from tasks"
  conn = PG.connect(:dbname =>'todo', :host => 'localhost')
  @rows = conn.exec(sql)
  conn.close

  erb :home
end

post "/create" do
  @task = params[:task_to_add]
  @due = params[:due_date]
  if (@due == '') || @due.nil?
    sql = "insert into tasks (task) values ('#{@task}')"
  else
    sql = "insert into tasks (task, due) values ('#{@task}', '#{@due}')"
  end
  conn = PG.connect(:dbname =>'todo', :host => 'localhost')
  conn.exec(sql)
  conn.close
  redirect to "/"
end

get "/new" do
  erb :new
end
