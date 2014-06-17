class Program <  ActiveRecord::Base

  validates_presence_of :name

  validates_uniqueness_of :name

  def inactive?
    is_active ? false : true
  end

  def active_status
    is_active ? 'Yes' : 'No'
  end
end
