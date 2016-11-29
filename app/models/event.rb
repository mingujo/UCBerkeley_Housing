# Table name: events
#
#  id              :integer(4)      not null, primary key
#  start_time       :datetime
#  end_time         :datetime
#  created_at      :datetime
#  updated_at      :datetime
#  event_series_id :integer(4)
#

class Event < ActiveRecord::Base
  attr_accessor :period, :frequency, :commit_button
  belongs_to :event_series
  validates_uniqueness_of :start_time
  validates :start_time, :end_time, :ca_id, :presence => true
  validate :validate_timings
  REPEATS = [
              "Does not repeat",
              "Weekly"         
  ]
  
  def validate_timings
    if start_time.present? and end_time.present?
      if (start_time > end_time)
        errors[:base] << "Start Time must be less than End Time"
      end
    end
  end
  
end
