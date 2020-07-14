require 'roo-xls'

def make
    xls = Roo::Spreadsheet.open("ps_xls.xls")
    sheet = xls.sheet(0)
    z=0
    sheet.each do |row|
        if z>0
            unless row[0] == nil
                consent = false;
                reqs = false;
                capacity = false;
                if row[8] == "Y"
                capacity = true;
                end
                if row[9] == "Y"
                reqs = true;
                end
                if row[10] == "Y"
                consent = true;
                end
                puts(row[0].to_i)
            end
        end
        z += 1
    end
end

make()