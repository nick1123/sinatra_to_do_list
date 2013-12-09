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
  # Switch from Sequel::SQLite::Dataset to Array so we can do operations like:
  #   @incomplete_tasks[index-1]
  @incomplete_tasks = []
  ::Task.where(:completed => false).order(:order_value).each do |task|
    @incomplete_tasks << task
  end

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

put '/swap_order_values/:id1/:id2' do
  task1 = ::Task.where(:id => params[:id1]).first
  task2 = ::Task.where(:id => params[:id2]).first
  tmp = task1.order_value
  task1.order_value = task2.order_value
  task2.order_value = tmp
  task1.save
  task2.save
  redirect to('/')
end
