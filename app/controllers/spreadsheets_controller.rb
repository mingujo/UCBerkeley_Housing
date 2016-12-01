require_relative '../helpers/fetch_sheets.rb'

class SpreadsheetsController < ApplicationController
    include SessionsHelper
    before_action :require_login
    before_action :require_admin_login, only: [:new, :create, :update, :destroy]
    
    def index
        @spreadsheets = Spreadsheet.all
    end
    
    def new #just renders view
        
    end
    
    def create
        spreadsheet_url = params[:ca][:spreadsheet_url]
        spreadsheet_id = /\/spreadsheets\/d\/([a-zA-Z0-9\-_]+)/.match(spreadsheet_url) 
        if !spreadsheet_id
            flash[:error] = "Invalid spreadsheet url"
            redirect_to new_spreadsheet_path
            return
        end
        spreadsheet_id = spreadsheet_id[1]
        
        days_in_month = params[:ca][:days_in_month].to_i
        if days_in_month < 28 or days_in_month > 31
            flash[:error] = "Invalid number of days in month"
            redirect_to cas_generate_path
            return
        end
      
        if !validate_date(id)
            flash[:error] = "Invalid date on spreadsheet. Please make sure the first day of the month is on the second row in the format of m/d/y weekday"
            redirect_to new_spreadsheet_path
            return
        end
      
        populate_spreadsheet(days_in_month, spreadsheet_id, spreadsheet_url)
        flash[:notice] = "Spreadsheet has been created"
    end
end