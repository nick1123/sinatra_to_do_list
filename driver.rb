require "rubygems"
require "sequel"
require "sqlite3"

# Connect to an in-memory database
DB = Sequel.sqlite

# Require models
Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file}

::List.create_table
