class Item < Sequel::Model
  many_to_one :list

  TABLE_NAME = :items

  def self.create_table
    # Creates the table unless the table already exists.
    ::DB.create_table? ::Item::TABLE_NAME do
      Integer :id, :primary_key => true
      Integer :list_id
      String  :name
      Boolean :completed, :default => false
    end

    lists = ::List.all

    # Add some data
    table_handle = ::DB[::Item::TABLE_NAME]

    table_handle.insert(:name => 'Laundry', :list_id => lists[0].id)
    table_handle.insert(:name => 'Make breakfast', :list_id => lists[0].id)

    table_handle.insert(:name => 'Program stuff', :list_id => lists[1].id)
    table_handle.insert(:name => 'Check reddit', :list_id => lists[1].id)

    ::Item.dataset = ::Item.dataset
  end

  def self.table_exists?
    ::DB.table_exists?(::Item::TABLE_NAME)
  end
end

