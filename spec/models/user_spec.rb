require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do

  let(:valid_attributes) do
    {
      email: 'brown@dogs.com',
      password: 'secret',
      firstname: 'makgwela',
      id_number: 1_234_567_890_123,
      surname: 'Mahladisa',
      password_confirmation: 'foobar',
      reset_token: 'some value'
    }
  end
  describe 'associations' do
    it { should have_one(:role) }
    it { should have_many(:kpi_results) }
    it { should have_many(:top_layer_administrators) }
    it { should have_many(:assurances) }
    it { should have_many(:kpi_owners) }
    it { should have_one(:subdepartmental_administrator) }
    it { should have_one(:departmental_administrator) }
    it { is_expected.to have_many(:activity_logs) }
    it { is_expected.to have_many(:roles).dependent(:destroy) }
  end # end of association description
  describe '#downcase_email' do
    before do
      @user = User.find(5)
    end
    it 'triggers downcase on save' do
      expect(@user.email).to receive(:downcase_email)
    end
  end

  # before do
  #     Attachment.any_instance.stub(:save_attached_files).and_return(true)
  #     @attachment = FactoryGirl.create :attachment
  #   end

  describe 'validations' do
    let(:user) { User.new(valid_attributes) }
    before do
      User.create(valid_attributes)
    end

    it 'downcase email' do
      user = User.new(valid_attributes)
      user.email = 'BROWN@DOGS.COM'
      expect(user.save).to eq false
      expect(assigns(user.email)).to be('BROWN@DOGS.COM'.downcase)
      expect(user.email).to eq('brown@dogs.com')
    end

    it { is_expected.to validate_presence_of(:firstname) }
    it { is_expected.to validate_length_of(:firstname).is_at_most(50) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_length_of(:email).is_at_most(255) }

    it 'asserts on matching a regular expression' do
      email = 'brown@dogs.com'
      VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      expect(email).to match VALID_EMAIL_REGEX
    end

    it 'requires a unique email (case_insensitive)' do
      user.email = 'brown@dogs.com'
      expect(user).to validate_uniqueness_of(:email).case_insensitive
    end

    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end # end of validation description

  before(:each) do
    @attr = {
      firstname: 'Example User',
      email: 'user@example.com',
      password: 'foobar',
      password_confirmation: 'foobar',
      id_number: '9108245248085'
    }
  end

  describe 'password' do
    before(:each) do
      @user = User.create!(@attr)
    end

    it 'Returns the hash digest of the given string.' do
      expect(@user).to respond_to(:password)
    end
  end
describe "token" do
  before do
    @user = User.find(5)
  end
  it 'Remembers token' do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end
describe "" do
  before do
    @user = User.find(5)
  end
  it 'authenticated? should return false for a user with nil digest' do
    assert_not @user.authenticated?
  end
end

  it 'Forgets a user.' do
  end

  describe 'activate account' do
    before do
      @user = User.find(5)
    end
    let(:mail) { UserMailer.account_activation(@user) }
    it 'renders the headers' do
      mail.subject.should eq('Account activation')
    end
  end

  describe 'confirmation' do
    before do
      @user = User.find(5)
    end
    it 'send an activation email' do
      delivery = UserMailer.account_activation(@user)
      expect(delivery).to receive(:deliver_now)
      should have_link('Activate Account', href: edit_account_activation_path(@user.activation_token,@user.id))
    end

    it 'Sets the password reset attributes(create_reset_digest).' do
      valid_attributes = FactoryGirl.create(:user, password: 'sableassets',password_confirmation: 'sableassets')
      visit(edit_password_reset_path(valid_attributes.reset_token,
                                     email: valid_attributes.email))
    end
    it 'Sends password reset email.' do
      UserMailer.password_reset(@user)
    end

    it 'is_expected.to resent password after 2 hours' do
    end
  end # end of confirmation description

  it 'Updates Kpi' do
  end

  it ' Returns true if a password reset has expired' do
  end

  it 'Converts email to all lower-case.' do
    user = build(:user)
    user.email = 'BROWN@DOGS.COM'
    expect(user.save).to be true
    expect(user.email).to eq('brown@dogs.com')
  end

  it 'Creates and assigns the activation token and digest.' do
    user = create(:user, :agent)
    expect(user.activation_token).to_not be_nil
    expect(user.activation_digest).to_not be_nil
  end
  describe "send email notifications" do
    before(:all) do
      @user = User.find(5)
    end
    it "should be able to send primary reminder email" do
      UserMailer.primary_reminder_email(@user)
    end
    it "should be able to send secondary reminder email" do
      UserMailer.secondary_reminder_email(@user)
    end
  end
end
