class List < Sequel::Model
  TABLE_NAME = :lists

  def self.create_table
    # Creates the table unless the table already exists.
    ::DB.create_table? ::List::TABLE_NAME do
      primary_key :id
      String :name
    end

    # Add some data
    table_handle = ::DB[::List::TABLE_NAME]
    table_handle.insert(:name => 'Home')
    table_handle.insert(:name => 'Work')

    # print out the number of records
    puts "List count: #{table_handle.count}"
  end

  def self.table_exists?
    ::DB.table_exists?(::List::TABLE_NAME)
  end
end
