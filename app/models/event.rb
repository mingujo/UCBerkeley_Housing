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
  
  def update_events(events, event)
    events.each do |e|
      begin 
        st, et = e.start_time, e.end_time
        e.attributes = event
        if event_series.period.downcase == 'monthly' or event_series.period.downcase == 'yearly'
          nst = DateTime.parse("#{e.start_time.hour}:#{e.start_time.min}:#{e.start_time.sec}, #{e.start_time.day}-#{st.month}-#{st.year}")  
          net = DateTime.parse("#{e.end_time.hour}:#{e.end_time.min}:#{e.end_time.sec}, #{e.end_time.day}-#{et.month}-#{et.year}")
        else
          nst = DateTime.parse("#{e.start_time.hour}:#{e.start_time.min}:#{e.start_time.sec}, #{st.day}-#{st.month}-#{st.year}")  
          net = DateTime.parse("#{e.end_time.hour}:#{e.end_time.min}:#{e.end_time.sec}, #{et.day}-#{et.month}-#{et.year}")
        end
      rescue
        nst = net = nil
      end
      if nst and net
        e.start_time, e.end_time = nst, net
        e.save
      end
    end
    
    event_series.attributes = event
    event_series.save
  end
  
  
  
end
