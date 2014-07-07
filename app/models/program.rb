class Program <  ActiveRecord::Base

  has_many :submissions

  validates_presence_of :name

  validates_uniqueness_of :name

  after_initialize :set_is_active_to_true

  def active_status
    is_active ? 'Yes' : 'No'
  end

  private

  def set_is_active_to_true
    self.is_active = true if self.new_record? && self.is_active.nil?
  end

end
