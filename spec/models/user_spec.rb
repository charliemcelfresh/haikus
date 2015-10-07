require 'spec_helper'

describe User do 
	before { @user = User.new(email: "user@example.com") }

	subject { @user }

	it { should respond_to(:email) }

	describe "when email is not present" do
    	before { @user.email = "" }
    	it { should_not be_valid }
  	end

  	describe "when email format is invalid" do

    	it "should be invalid" do 
     	 	addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com
        	foo@bar+baz.com foo@bar..com]
      		addresses.each do |invalid_address|
       			@user.email = invalid_address
        		expect(@user).not_to be_valid
      		end
    	end
  	end

	describe "when email format is valid" do
	    it "should be valid" do
		    addresses =%w[user@foo.COM A_US-ER@f.b.org first.lst@foo.jp a+b@baz.cn]
		    addresses.each do |valid_address|
		      	@user.email = valid_address
		        expect(@user).to be_valid
		    end
	    end
	end

	describe "when email addresses is already taken" do
	    before do
	      user_with_same_email =@user.dup   
	      # case with same email address
	      user_with_same_email.email = @user.email.upcase  
	      # should do nothing if the test is case sensitive
	      user_with_same_email.save 
	      # if the case is invalid, like the one above, save will be false, which is what we want
	    end 
	    it { should_not be_valid }
	end

	describe "email address with mixed case" do
	    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

	    it "should be saved as all lower-case" do
		    @user.email = mixed_case_email
		    @user.save
		    expect(@user.reload.email).to eq mixed_case_email.downcase
	    end
	end
end