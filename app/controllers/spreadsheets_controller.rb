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
        # need to know # of months
        spreadsheet_url = params[:ca][:spreadsheet_url]
        id = /\/spreadsheets\/d\/([a-zA-Z0-9-_]+)/.match(spreadsheet_url)[1] 
        days_in_month = params[:ca][:days_in_month]
        generate_spreadsheet(days_in_month, id, spreadsheet_url)
        flash[:notice] = "Spreadsheet has been created"
    end
end