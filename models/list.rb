class List < Sequel::Model
  one_to_many :items

  TABLE_NAME = :lists

  def self.create_table
    # Creates the table unless the table already exists.
    ::DB.create_table? ::List::TABLE_NAME do
      Integer :id, :primary_key => true
      String :name
    end

    # Add some data
    table_handle = ::DB[::List::TABLE_NAME]
    table_handle.insert(:name => 'Home')
    table_handle.insert(:name => 'Work')

    ::List.dataset = ::List.dataset
  end

  def self.table_exists?
    ::DB.table_exists?(::List::TABLE_NAME)
  end
end
