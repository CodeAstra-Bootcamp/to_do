class Task < ActiveRecord::Base
  validates :title, presence: true

  def done?
    !self.done_at.nil?
  end
end
