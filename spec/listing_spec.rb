require 'spec_helper'

describe Listing do	

    file =  './cfsinventory_test.csv'

    context "csv uploader" do 
        it "should upload listings" do
            # p "hello"
            expect(Listing.import_listings(file)).to eq(2)
            # p "hello end"            
        end         
    end


end
