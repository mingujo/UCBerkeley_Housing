require_relative '../helpers/fetch_sheets.rb'

class SpreadsheetsController < ApplicationController
    include SessionsHelper
    before_action :require_login
    before_action :require_admin_login, only: [:new, :create, :destroy]
    
    
    
    def index
        @spreadsheets = Spreadsheet.all
    end
    
    def new 
        @spreadsheet = Spreadsheet.new
    end
    

    def spreadsheet_exists(month, year)
        if Spreadsheet.get_id_by_date(month, year)
            return true
        end
        return false
    end
    
    def create
        year = params[:ca][:year].to_i
        month = params[:ca][:month].to_i
        if spreadsheet_exists(month, year)
            flash[:error] = "Spreadsheet for this month and year already exists"
            redirect_to new_spreadsheet_path
            return
        end
        if year.to_s.length != 4
            flash[:error] = "Please enter the year in YYYY format."
            redirect_to new_spreadsheet_path
            return
        end
        if month < 1 or month > 12
            flash[:error] = "Please enter a month from 1-12."
            redirect_to new_spreadsheet_path
            return
        end
        date = Date.new(year, month, 1)
        
        link = params[:ca][:link]
        spreadsheet_id = /\/spreadsheets\/d\/([a-zA-Z0-9\-_]+)/.match(link) 
        if !spreadsheet_id
            flash[:error] = "Invalid spreadsheet url"
            redirect_to new_spreadsheet_path
            return
        end
        spreadsheet_id = spreadsheet_id[1]
        
        @spreadsheet = Spreadsheet.new({:month => date.month, :year => date.year, :spreadsheet_id => spreadsheet_id, :link => link}) 
        if @spreadsheet.save
            populate_spreadsheet(date, link, spreadsheet_id)
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