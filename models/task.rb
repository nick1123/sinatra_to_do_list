class Task < Sequel::Model
  TABLE_NAME = :tasks

  def self.create_table
    # Creates the table unless the table already exists.
    ::DB.create_table? ::Task::TABLE_NAME do
      Integer :id, :primary_key => true
      String  :name
      Boolean :completed,   :default => false
      Integer :order_value, :null => false
    end

    ::Task.dataset = ::Task.dataset

    # Add some data
    ::Task.create(:name => 'Eat')
    ::Task.create(:name => 'Sleep')
    ::Task.create(:name => 'Code')
  end

  def self.table_exists?
    ::DB.table_exists?(::Task::TABLE_NAME)
  end

  def before_save
    if ::Task.count == 0
      self.order_value = 1
    else
      self.order_value ||= DB[::Task::TABLE_NAME].max(:order_value) + 1
    end

    super
  end
end
