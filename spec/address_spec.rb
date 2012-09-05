require_relative 'spec_helper'

describe 'Address' do
  context "#new" do
    it "instantiates object with address" do
      @address = Transport::Address.new(street: "717 California St",
                             city: "San francisco",
                             state: "CA",
                             zip: "94108",
                             created_at: Time.now,
                             user_id: 1)
      @address.state.should eq "CA"
      @address.zip.should eq "94108"
    end

    it 'can parse a string from google into a valid input hash for ActiveRecord' do
      string = '2006B Lombard St, San Francisco, CA 94123'
      address_hash = Transport::Address.str_from_google(string)
      address_hash.should be_an_instance_of Hash
      address_hash[:zip].should == "94123"
    end
  end

  context "#db_to_str" do
    it "converts the values in a row in the Addresses table from a hash to a string" do
      @address = Transport::Address.new( street: "717 California St",
                              city: "San Francisco",
                              state: "CA",
                              zip: "94108",
                              created_at: Time.now,
                              user_id: 1)
      address_hash = @address.db_to_str
      address_hash.should eq "717 California St, San Francisco, CA, 94108"
    end
  end
end
