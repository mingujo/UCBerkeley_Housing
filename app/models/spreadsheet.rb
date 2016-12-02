class Spreadsheet < ActiveRecord::Base
    validates :month, :year, :spreadsheet_id, :link, :presence => true
    
    
    
    def self.get_id_by_date(month, year)
        spreadsheet = find_by(month: month, year: year)
        if spreadsheet.nil?
            return nil
        end
        return spreadsheet.spreadsheet_id
    end
    
    #the template sheet is a spreadsheet whose first page is the sheet that will be copied 
    #when populating new spreadsheets. it has month and year 0.
    def self.get_template_sheet
        return Spreadsheet.all[0]
       # return Spreadsheet.find_by(month: 0, year: 0)
    end
    
    
    
end