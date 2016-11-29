include EventsHelper

class EventsController < ApplicationController
  before_action :require_login
  skip_before_filter :verify_authenticity_token
  
  @@THIRTY_MIN = 1800
    
  def new
    @event = Event.new(:end_time => 30.minutes.from_now, :period => "Does not repeat")
    @ca = Ca.find(params[:ca_id])
    render :json => {:form => render_to_string(:partial => 'form')}
  end
  
  def create
    if params[:event][:period] == "Does not repeat"
      event = Event.new(event_params)
    else
      event = EventSeries.new(event_params)
    end
    starttime = event.start_time
    if starttime >= event.end_time
      render :text => "Please input valid start and end time.", :status => 422
      return
    end
    while event.end_time - starttime > 0
      if event.class == Event
        curr_event = Event.new(:start_time => starttime,
                               :end_time => starttime + @@THIRTY_MIN,
                               :ca_id => event[:ca_id])
      else
        curr_event = EventSeries.new(:start_time => starttime,
                               :end_time => starttime + @@THIRTY_MIN,
                               :ca_id => event[:ca_id],
                               :period => event[:period],
                               :frequency => event[:frequency])
      end
      if curr_event.class == Event and curr_event.save
        Timeslot.create!(:starttime => starttime,
                         :endtime => starttime + @@THIRTY_MIN,
                         :ca_id => event[:ca_id])
        starttime += @@THIRTY_MIN
      elsif curr_event.class == EventSeries and curr_event.save
        starttime += @@THIRTY_MIN
      else
        render :text => "The timeslot already exists. Please try again.", :status => 422
        return
      end
    end
    render :nothing => true
  end
  
  def index
  end
  
  def get_events
    @events = Event.where(["start_time >= '#{Time.at(params['start'].to_i).to_formatted_s(:db)}' and end_time <= '#{Time.at(params['end'].to_i).to_formatted_s(:db)}'"] )
    events = make_event_json(@events)
    render :text => events.to_json
  end
  
  
  def move
    @event = Event.find_by_id(params[:id])
    ts = Timeslot.where(:ca_id => @event.ca_id, :starttime => @event.start_time).first
    if @event and ts
      @event.start_time = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@event.start_time))
      @event.end_time = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@event.end_time))
      ts.starttime = @event.start_time
      ts.endtime = @event.end_time
      @event.save
      ts.save
    end
    render :nothing => true
  end
  
  def edit
    @event = Event.find_by_id(params[:id])
    render :json => { :form => render_to_string(:partial => 'edit_form') } 
  end
  
  def update
    @event = Event.find_by_id(params[:id])
    ts = Timeslot.where(:ca_id => @event.ca_id, :starttime => @event.start_time).first
    @event.attributes = event_params
    if @event.attributes["end_time"] - @event.attributes["start_time"] != @@THIRTY_MIN
      render :text => "Please input valid start and end time. \nThe duration should be 30 minutes", :status => 422
      return
    end
    if params[:event][:commit_button] == "Update All Occurrence"
      events = Event.where(:event_series_id => @event.event_series_id)
      for event in events
        ts = Timeslot.find_by_starttime_and_ca_id(event.start_time, event.ca_id)
        ts.starttime = Time.parse(ts.starttime.time.to_s[0,10]+" "+@event.start_time.to_s[11,15])
        ts.endtime = Time.parse(ts.starttime.time.to_s[0,10]+" "+@event.end_time.to_s[11,15])
        ts.save
        event.start_time = Time.parse(event.start_time.time.to_s[0,10]+" "+@event.start_time.to_s[11,15])
        event.end_time = Time.parse(event.end_time.time.to_s[0,10]+" "+@event.end_time.to_s[11,15])
        event.save
      end
      render :nothing => true 
      return
    end
    ts.starttime = @event.start_time
    ts.endtime = @event.end_time
    ts.save
    @event.save
    render :nothing => true    
  end  
  
  def destroy
    @event = Event.find_by_id(params[:id])
    if params[:delete_all] == "true"
      events = Event.where(:event_series_id => @event.event_series_id)
      for event in events
        if Timeslot.find_by_starttime_and_ca_id(event.start_time, event.ca_id)
          ts_id = Timeslot.find_by_starttime_and_ca_id(event.start_time, event.ca_id)[:id]
          Timeslot.destroy(ts_id)
        end
        event.destroy
      end
      @event.event_series.destroy
    else
      @event.destroy
      if Timeslot.find_by_starttime_and_ca_id(@event.start_time, @event.ca_id)
        ts_id = Timeslot.find_by_starttime_and_ca_id(@event.start_time, @event.ca_id)[:id]
        Timeslot.destroy(ts_id)
      end
    end
    render :nothing => true   
  end
    
  def require_login
    if session[:user_id].nil?
      redirect_to '/auth/login'
    else
      user = Ca.get_by_user_id(session[:user_id])
      if user.nil?
        user = Admin.get_by_user_id(session[:user_id])
      end
      if user.nil?
        flash[:notice] = "This email is not authorized"
        session[:user_id] = nil
        redirect_to '/auth/login'
      end
    end
  end

  private
    def event_params
      params.require(:event).permit('start_time(1i)', 'start_time(2i)', 'start_time(3i)', 'start_time(4i)', 'start_time(5i)', 'end_time(1i)', 'end_time(2i)', 'end_time(3i)', 'end_time(4i)', 'end_time(5i)', 'period', 'frequency', 'commit_button', 'ca_id')
    end
  
end
