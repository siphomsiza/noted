require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
let(:valid_attributes) {
    {
      email: "brown@dogs.com",
       password: "secret",
       firstname: "makgwela",
     }
  }
 
describe 'associations' do

	it {should belong_to(:department) }
 	it {should have_many(:activity_logs)}
 	it {should have_one(:role).dependent(:destroy)}
	end #end of association description

describe 'validations' do

	let(:user) { User.new(valid_attributes) }
		before do
      	User.create(valid_attributes)
	end

	it "Converts email to all lower case before saving" do
        user = User.new(valid_attributes)
        user.email == "BROWN@DOGS.COM"
        expect(user.save).to be false
        expect(user.email).to eq("brown@dogs.com")
	end

	it { expect(user).to validate_presence_of(:firstname) }
	it { expect(user).to ensure_length_of(:firstname).is_at_most(50) }
  	it { expect(user).to validate_presence_of(:email)}
	it { should ensure_length_of(:email).is_at_most(255) }
	it "asserts on matching a regular expression" do
		email = "brown@dogs.com"
		VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
		expect(email).to match VALID_EMAIL_REGEX
	end

	it "requires a unique email (case sensitive)" do
      	user.email = "brown@dogs.com"
      	expect(user).to validate_uniqueness_of(:email)
	end

	it { expect(user).to validate_presence_of(:password) }
	it { expect(user).to ensure_length_of(:password).is_at_least(6) }
	end #end of validation desciption

	xit "Returns the hash digest of the given string." do
	end

	xit "Returns a random token" do
	end

	xit "Remembers a user in the database for use in persistent sessions." do
	end

	xit "Returns true if the given token matches the digest." do
	end

	xit "Forgets a user." do
	end

	xit "Activates an account." do
	end

describe 'confirmation' do

	it "should send an activation email after creating a user" do
		dummy = create(:user)
      expect(ActionMailer::Base.deliveries.count).to eq 0
	end

	xit "Sends password reset email." do
	end

	xit "Should resent password after 2 hours" do
    end #end of confirmation description
end
	
	xit "Sets the password reset attributes." do
	end
	
	xit "Updates Kpi" do
	end

	xit " Returns true if a password reset has expired" do 
	end
	
    xit "searches users by its firstname or surname" do
    end

    xit "Creates and assigns the activation token and digest." do
    	user = create(:user, :agent)
    	expect(user.activation_token).to_not be_nil
  		expect(user.activation_digest).to_not be_nil
    end 
end

