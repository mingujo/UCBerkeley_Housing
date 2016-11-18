require 'byebug'
class EventsController < ApplicationController
    
  def new
    @event = Event.new(:end_time => 1.hour.from_now, :period => "Does not repeat")
    @ca = Ca.find(params[:ca_id])
    render :json => {:form => render_to_string(:partial => 'form')}
  end
  
  def create
    if params[:event][:period] == "Does not repeat"
      event = Event.new(event_params)
    else
      event = EventSeries.new(event_params)
    end
    if event.save
      if event.class.name == 'Event'
        Timeslot.create!(:starttime => event[:start_time],
                         :endtime => event[:end_time],
                         :ca_id => event[:ca_id])
      end
      render :nothing => true
    else
      render :text => event.errors.full_messages.to_sentence, :status => 422
    end
    
  end
  
  def index
  end
  
  
  def get_events
    @events = Event.where(["start_time >= '#{Time.at(params['start'].to_i).to_formatted_s(:db)}' and end_time <= '#{Time.at(params['end'].to_i).to_formatted_s(:db)}'"] )
    events = [] 
    @events.each do |event|
      events << {:id => event.id, :start => "#{event.start_time.iso8601}", :end => "#{event.end_time.iso8601}", :recurring => (event.event_series_id)? true: false}
    end
    render :text => events.to_json
  end
  
  
  def get_ca_events
    @events = Event.where(["start_time >= '#{Time.at(params['start'].to_i).to_formatted_s(:db)}' and end_time <= '#{Time.at(params['end'].to_i).to_formatted_s(:db)}'"] ) #.where...
    events = [] 
    @events.each do |event|
      events << {:id => event.id, :start => "#{event.start_time.iso8601}", :end => "#{event.end_time.iso8601}", :recurring => (event.event_series_id)? true: false}
    end
    render :text => events.to_json
  end
  
  def move
    @event = Event.find_by_id(params[:id])
    if @event
      @event.start_time = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@event.start_time))
      @event.end_time = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@event.end_time))
      @event.save
    end
    render :nothing => true
  end
  
  
  def resize
    @event = Event.find_by_id(params[:id])
    if @event
      @event.end_time = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@event.end_time))
      @event.save
    end    
    render :nothing => true
  end
  
  def edit
    @event = Event.find_by_id(params[:id])
    render :json => { :form => render_to_string(:partial => 'edit_form') } 
  end
  
  def update
    @event = Event.find_by_id(params[:event][:id])
    if params[:event][:commit_button] == "Update All Occurrence"
      @events = @event.event_series.events #.find(:all, :conditions => ["start_time > '#{@event.start_time.to_formatted_s(:db)}' "])
      @event.update_events(@events, event_params)
    elsif params[:event][:commit_button] == "Update All Following Occurrence"
      @events = @event.event_series.events.find(:all, :conditions => ["start_time > '#{@event.start_time.to_formatted_s(:db)}' "])
      @event.update_events(@events, event_params)
    else
      @event.attributes = event_params
      @event.save
    end
    render :nothing => true    
  end  
  
  def destroy
    @event = Event.find_by_id(params[:id])
    if params[:delete_all] == 'true'
      @event.event_series.destroy
      # not implemented yet
    elsif params[:delete_all] == 'future'
      @events = @event.event_series.events.find(:all, :conditions => ["start_time > '#{@event.start_time.to_formatted_s(:db)}' "])
      @event.event_series.events.delete(@events)
    else
      @event.destroy
      if Timeslot.find_by_starttime_and_ca_id(@event.start_time, @event.ca_id)
        ts_id = Timeslot.find_by_starttime_and_ca_id(@event.start_time, @event.ca_id)[:id]
        Timeslot.destroy(ts_id)
      end
    end
    render :nothing => true   
  end

  private
    def event_params
      params.require(:event).permit('start_time(1i)', 'start_time(2i)', 'start_time(3i)', 'start_time(4i)', 'start_time(5i)', 'end_time(1i)', 'end_time(2i)', 'end_time(3i)', 'end_time(4i)', 'end_time(5i)', 'period', 'frequency', 'commit_button', 'ca_id')
    end
  
end
