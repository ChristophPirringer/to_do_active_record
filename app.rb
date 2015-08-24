require('pg')
require('sinatra')
require('sinatra/reloader')
require("sinatra/activerecord")
require('./lib/task')
require('./lib/list')
also_reload('lib/**/*.rb')
require 'pry'



get("/") do
  @tasks = Task.all()
	erb(:index)
end

get('/tasks/:id/edit') do
  @task = Task.find(params.fetch("id").to_i())
  erb(:task_edit)
end

patch("/tasks/:id") do
  description = params.fetch("description")
  @task = Task.find(params.fetch("id").to_i())
  @task.update({:description => description})
  @tasks = Task.all()
  erb(:index)
end

get("/clear") do
	List.delete_all()
  @tasks = Task.all()
	erb(:index)
end

get("/lists") do
	@lists = List.all()
	erb(:lists)
end

get("/lists/new") do
	erb(:list_form)
end

post("/lists") do
	name = params.fetch("name")
	list = List.new({:name => name, :id => nil})
	list.save()
  @lists = List.all()
	erb(:lists)
end

get("/lists/:id") do
	@list = List.find(params.fetch("id").to_i())
	erb(:list)
end

get("/tasks/:id") do
	@list = params.fetch("id").to_i()
	erb(:task_form)
end

post("/tasks/:id") do
	description = params.fetch("description")
	list_id = params.fetch("id").to_i()
	@list = List.find(list_id)
	@task = Task.new({:description => description, :list_id => list_id})
	@task.save()
	erb(:list)
end
