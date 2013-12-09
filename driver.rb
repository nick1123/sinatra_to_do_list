require "rubygems"
require "sequel"
require "sqlite3"
require "sinatra"
require "slim"

# Connect to an in-memory database
DB = Sequel.sqlite

# Require models
Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file}

# Create tables and insert dummy data
::Task.create_table unless ::Task.table_exists?

get '/' do
  @incomplete_tasks = ::Task.where(:completed => false)
  @completed_tasks  = ::Task.where(:completed => true)
  slim :tasks
end

post '/' do
  ::Task.create(:name => params['task']['name'])
  redirect to('/')
end

delete '/task/:id' do
  ::Task.where(:id => params[:id]).destroy
  redirect to('/')
end

put '/task/:id' do
  task = ::Task.where(:id => params[:id]).first
  task.completed = !task.completed
  task.save
  redirect to('/')
end
