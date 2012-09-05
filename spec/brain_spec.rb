require_relative 'spec_helper'

describe 'Brain' do
  before(:each) do
    ivan = Transport::User.new(:first_name => 'Ivan', :last_name => 'Stroganoff')
    ivan.save
    @my_brain = Transport::Brain.new(ivan)
  end

  after (:each) do
    Transport::Address.destroy_all
  end

  context '#new' do
    it 'instantiates with user object' do
      @my_brain.user.first_name.should eq 'Ivan'
    end
  end

  context '#list addresses' do
    it 'returns an array' do
      @my_brain.list_addresses.should be_an_instance_of Array
    end

    it 'returns an array of strings representing addresses' do
      addr1 = @my_brain.user.addresses.new(:street     => "717 california st",
                                           :city       => "san fran",
                                           :state      => "CA",
                                           :zip        => "94108",
                                           :created_at => "2000-01-01 20:15:50")
      addr2 = @my_brain.user.addresses.new(:street     => "2006A Webster St",
                                           :city       => "san francisco",
                                           :state      => "CA",
                                           :zip        => "94123")
      [addr1,addr2].each{|addr| addr.save}
      @my_brain.list_addresses[0].should_not be nil
      @my_brain.list_addresses[1].should_not be nil
    end
  end

  context '#decision' do
    before(:each) do
      RestClient.stub!(:get).and_return(driving)
    end

    it 'takes two arguments' do
      lambda {@my_brain.decision()}.should raise_error
      lambda {@my_brain.decision("717 california st, san francisco, CA, 94108", "2006A Webster St, san francisco, CA, 94123")}.should_not raise_error
    end

    it 'returns a symbol' do
      @my_brain.decision("717 california st, san francisco, CA, 94108", "2006A Webster St, san francisco, CA, 94123").should == :driving
    end
  end
end
