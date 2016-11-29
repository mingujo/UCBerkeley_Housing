include EventsHelper
require 'byebug'

class EventsController < ApplicationController
  before_action :require_login
    
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
    @event = Event.find_by_id(params[:event][:id])
    ts = Timeslot.where(:ca_id => @event.ca_id, :starttime => @event.start_time).first
    @event.attributes = event_params
    @event.save
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
