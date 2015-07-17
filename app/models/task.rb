class Task < ActiveRecord::Base
  def done?
    !self.done_at.nil?
  end
end
