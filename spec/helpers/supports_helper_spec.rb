require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the SupportsHelper. For example:
#
# describe SupportsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe SupportsHelper do

	it "should call the corrent user method" do
		ActionController.stub(:current_user).and_return(1)
		helper.support_user.should == 1
	end

	it "should return admin correctly" do
		current_user = Support.new
		ActionController.stub!(:current_user).and_return(current_user)
		current_user.stub!(:admin?).and_return(true)
		helper.support_admin?.should be_true
	end
  
end
