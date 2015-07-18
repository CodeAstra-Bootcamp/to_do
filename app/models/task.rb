class Task < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true

  def done?
    !self.done_at.nil?
  end
end
