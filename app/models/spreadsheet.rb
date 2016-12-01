class Spreadsheet < ActiveRecord::Base
    validates :month, :year, :spreadsheet_id, :link, :presence => true
    
    
    
    def self.get_id_by_date(month, year)
        spreadsheet = find_by(month: month, year: year)
        if spreadsheet.nil?
            return nil
        end
        return spreadsheet.spreadsheet_id
    end
    
    
end