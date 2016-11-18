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
require 'date'
RECURRING_EVENTS_UPTO = (Date.today.beginning_of_year + 1.years).to_time

class EventSeries < ActiveRecord::Base
  attr_accessor :commit_button
  
  validates_presence_of :frequency, :period, :start_time, :end_time
  
  has_many :events, :dependent => :destroy

  after_create :create_events_until_end_time
  
  # def create_events_until_end_time(end_time=RECURRING_EVENTS_UPTO)
  #   st = start_time
  #   et = end_time
  #   p = r_period(period)
  #   nst, net = st, et
  #   while frequency.send(p).from_now(st) <= end_time
  #     nst = st = frequency.send(p).from_now(st)
  #     net = et = frequency.send(p).from_now(nst)
  #     self.events.create(:title => title, :description => description, :all_day => all_day, :start_time => nst, :end_time => net)
  #     Timeslot.create!(:starttime => event[:start_time],
  #       :endtime => event[:end_time],
  #       :ca_id => event[:ca_id])
      
  #     if period.downcase == 'monthly' or period.downcase == 'yearly'
  #       begin 
  #         nst = DateTime.parse("#{start_time.hour}:#{start_time.min}:#{start_time.sec}, #{start_time.day}-#{st.month}-#{st.year}")  
  #         net = DateTime.parse("#{end_time.hour}:#{end_time.min}:#{end_time.sec}, #{end_time.day}-#{et.month}-#{et.year}")
  #       rescue
  #         nst = net = nil
  #       end
  #     end
  #   end
  # end
  
  # def r_period(period)
  #   case period
  #     when 'Daily'
  #     p = 'days'
  #     when "Weekly"
  #     p = 'weeks'
  #     when "Monthly"
  #     p = 'months'
  #   end
  #   return p
  # end
  
end
