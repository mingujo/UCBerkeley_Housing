include EventsHelper

class CasController < ApplicationController
  include SessionsHelper
  before_action :set_ca, only: [:show, :edit, :update, :destroy]
  before_action :require_login
  before_action :require_ca_login, only: [:show, :edit, :update]
  before_action :require_admin_login, only: [:index, :new, :create, :update, :destroy]
  
  def ca_params
    params.require(:ca).permit(:name, :email, :phone_number)
  end

  # GET /cas
  # GET /cas.json
  def index
    @ca = Ca.all
  end

  # GET /cas/1
  # GET /cas/1.json
  def show
  end

  # GET /cas/new
  def new
    print "In new method"
    @ca = Ca.new
  end

  # GET /cas/1/edit
  def edit
    # if @ca.update_attributes(ca_params)
    #   flash[:success] = "Profile updated"
    #   redirect_to @ca
    # else
    #   render 'edit'
    # end
  end

  # POST /cas
  # POST /cas.json
  def create
    print "In create method"
    params.permit!
    @ca = Ca.create(ca_params)
    
    if @ca.save
      puts "In create now saving and redirecting to"
      redirect_to cas_path
    else
      redirect_to action: 'error'
    end
    
  end
  
  def error
  end

  # PATCH/PUT /cas/1
  # PATCH/PUT /cas/1.json
  def update
    params.permit!
    respond_to do |format|
      if @ca.update(ca_params)
        format.html { redirect_to @ca, notice: 'Ca was successfully updated.' }
        format.json { render :show, status: :ok, location: @ca }
      else
        format.html { render :edit }
        format.json { render json: @ca.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cas/1
  # DELETE /cas/1.json
  def destroy
    Event.destroy_all(:ca_id => @ca.id)
    Timeslot.destroy_all(:ca_id => @ca.id)
    @ca.destroy
    respond_to do |format|
      format.html { redirect_to cas_url, notice: 'Ca was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def get_ca_events
    ca_id = params[:ca_id]
    @events = Event.where(["start_time >= '#{Time.at(params['start'].to_i).to_formatted_s(:db)}' and end_time <= '#{Time.at(params['end'].to_i).to_formatted_s(:db)}'"] ).where(:ca_id => ca_id)
    events = make_event_json(@events, ca_id=ca_id) 
    render :text => events.to_json
	 end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ca
      @ca = Ca.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ca_params
      params.fetch(:ca, {})
    end
    
    def require_ca_login
      user = Ca.get_by_user_id(session[:user_id])
      unless user.nil?
        if @ca.id != user.id
          flash[:notice] = "You cannot access that user's info"
          redirect_to ca_path(user.id)
        end
      end
    end
    
    def require_admin_login
      user = Admin.get_by_user_id(session[:user_id])
      if user.nil?
        flash[:notice] = "You must be admin to access that page"
        user = Ca.get_by_user_id(session[:user_id])
        redirect_to ca_path(user.id)
      end
    end
end
