class CasController < ApplicationController
  before_action :set_ca, only: [:show, :edit, :update, :destroy]
  before_action :require_login
  
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
    @ca.destroy
    respond_to do |format|
      format.html { redirect_to cas_url, notice: 'Ca was successfully destroyed.' }
      format.json { head :no_content }
    end
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
end
