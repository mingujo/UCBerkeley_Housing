# Table name: event_series
#
#  id         :integer(4)      not null, primary key
#  frequency  :integer(4)      default(1)
#  period     :string(255)     default("months")
#  start_time  :datetime
#  end_time    :datetime
#  all_day    :boolean(1)
#  created_at :datetime
#  updated_at :datetime
#
require 'time'

class EventSeries < ActiveRecord::Base
  validates_presence_of :frequency, :period, :start_time, :end_time
  validates_uniqueness_of :start_time
  validate :validate_timings
  has_many :events, :dependent => :destroy

  after_create :create_events_until_end_time

  def validate_timings
    if start_time.present? and end_time.present?
      if (start_time > end_time)
        errors[:base] << "Start Time must be less than End Time"
      end
    end
  end
  
  def create_events_until_end_time()
    next_month = (start_time.month.to_i + 1).to_s
    end_recur = Time.parse(start_time.year.to_s+"-"+next_month+"-"+1.to_s)
    st = start_time
    et = end_time
    p = "weeks"
    week_counter = 0
    while week_counter < frequency
      if week_counter.send(p).from_now(st) > end_recur
        break
      end
      if week_counter == 0
        self.events.create(:start_time => st,
                          :end_time => et,
                          :ca_id => ca_id)
        Timeslot.create!(:starttime => st,
                         :endtime => et,
                         :ca_id => ca_id)
      else
        nst = week_counter.send(p).from_now(st)
        net = week_counter.send(p).from_now(et)
        self.events.create(:start_time => nst,
                          :end_time => net,
                          :ca_id => ca_id)
        Timeslot.create!(:starttime => nst,
                         :endtime => net,
                         :ca_id => ca_id)
      end
      week_counter += 1
    end
  end

  
end
