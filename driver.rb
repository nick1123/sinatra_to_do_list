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
  @tasks = ::Task.all
  slim :tasks
end

post '/' do
  ::Task.create(:name => params['task']['name'])
  @tasks = ::Task.all
  slim :tasks
end

delete '/task/:id' do
  ::Task.where(:id => params[:id]).destroy
  redirect to('/')
end
