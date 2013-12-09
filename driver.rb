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
::List.create_table unless ::List.table_exists?
::Item.create_table unless ::Item.table_exists?

get '/' do
  @lists = ::List.all
  slim :lists
end
