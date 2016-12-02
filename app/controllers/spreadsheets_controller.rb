require_relative '../helpers/fetch_sheets.rb'

class SpreadsheetsController < ApplicationController
    include SessionsHelper
    # before_action :require_login
    # before_action :require_admin_login, only: [:new, :create, :update, :destroy]
    
    
    
    def index
        @spreadsheets = Spreadsheet.all
    end
    
    def new 
        @spreadsheet = Spreadsheet.new
    end
    
    
    def get_date
        year = params[:ca][:year].to_i
        month = params[:ca][:month].to_i
        date = Date.new(year, month, 1)
        return date
    end
    

    
    def create
        #byebug
        date = get_date
        
        link = params[:ca][:spreadsheet_url]
        spreadsheet_id = /\/spreadsheets\/d\/([a-zA-Z0-9\-_]+)/.match(link) 
        if !spreadsheet_id
            flash[:error] = "Invalid spreadsheet url"
            redirect_to new_spreadsheet_path
            return
        end
        spreadsheet_id = spreadsheet_id[1]
        
        @spreadsheet = Spreadsheet.new({:month => date.month, :year => date.year, :spreadsheet_id => spreadsheet_id, :link => link}) 
        if @spreadsheet.save
            days_in_month = date.end_of_month.day
            #populate_spreadsheet(days_in_month, spreadsheet_id, link)
            flash[:success] = "Spreadsheet has been created"
            redirect_to spreadsheets_path
        end
    end
    
    
    def destroy
        Spreadsheet.find(params[:id]).destroy
        flash[:notice] = "Spreadsheet was removed from this app, but still exists."
        redirect_to spreadsheets_path
    end
    
    
    private
        def spreadsheet_params
            params.require(:spreadsheet).permit('month', 'year', 'spreadsheet_id', 'link')
        end
        
    
end