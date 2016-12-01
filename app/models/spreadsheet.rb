class Spreadsheet < ActiveRecord::Base
    def self.get_url_by_date(month, year)
        spreadsheet = find_by(month: month, year: year)
        if spreadsheet.nil?
            return nil
        end
        return spreadsheet.url
    end
end