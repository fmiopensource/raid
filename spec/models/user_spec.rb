require 'spec_helper'

describe User do
  describe "full_name" do
    it "should show the users full name" do
      @user = Factory.create(:user, :first_name => "John", :last_name => "Doe")
      @user.full_name.should == "John Doe"
    end
  end
end
