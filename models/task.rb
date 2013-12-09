class Task < Sequel::Model
  TABLE_NAME = :tasks

  def self.create_table
    # Creates the table unless the table already exists.
    ::DB.create_table? ::Task::TABLE_NAME do
      Integer :id, :primary_key => true
      String  :name
      Boolean :completed, :default => false
    end

    # Add some data
    table_handle = ::DB[::Task::TABLE_NAME]
    table_handle.insert(:name => 'Eat')
    table_handle.insert(:name => 'Sleep')
    table_handle.insert(:name => 'Code')

    ::Task.dataset = ::Task.dataset
  end

  def self.table_exists?
    ::DB.table_exists?(::Task::TABLE_NAME)
  end
end
