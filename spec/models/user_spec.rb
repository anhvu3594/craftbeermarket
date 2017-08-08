require 'rails_helper'

RSpec.describe User, type: :model do
  let (:user) { FactoryGirl.build(:user) }

  it { expect(user).to have_one(:passport) }

  it { expect(user).to have_many(:tokens) }

  it 'should be valid with a name, email, and password' do
    expect(user).to be_valid
  end

  # it 'is invalid without a name' do
  #   invalidUser = FactoryGirl.build(:user, name: nil)
  #   invalidUser.valid?
  #   expect(invalidUser.errors[:name]).to include("can't be blank")
  # end

  it { expect(FactoryGirl.build(:user, name: nil)).to validate_presence_of(:name) }

  # it 'is invalid without an email address' do
  #   invalidUser = FactoryGirl.build(:user, email: nil)
  #   invalidUser.valid?
  #   expect(invalidUser.errors[:email]).to include("can't be blank")
  # end

  it { expect(FactoryGirl.build(:user, email: nil)).to validate_presence_of(:email) }

  # it 'is invalid with a duplicate email address' do
  #   FactoryGirl.create(:user, email: "test@gmail.com")
  #   invalidUser = FactoryGirl.build(:user, email: "test@gmail.com")
  #   invalidUser.valid?
  #   expect(invalidUser.errors[:email]).to include("has already been taken")
  # end

  it { expect(user).to validate_uniqueness_of(:email).case_insensitive }

  # it 'is invalid without a password' do
  #   invalidUser = FactoryGirl.build(:user, password: nil)
  #   invalidUser.valid?
  #   expect(invalidUser.errors[:password]).to include("can't be blank")
  # end

  it { expect(FactoryGirl.build(:user, password: nil)).to validate_presence_of(:password) }

  # it "is invalid if password's length is 5" do
  #   invalidUser = FactoryGirl.build(:user, password: "12345")
  #   invalidUser.valid?
  #   expect(invalidUser.errors[:password]).to include("is too short (minimum is 6 characters)")
  # end

  it { expect(FactoryGirl.build(:user, password: '12345')).to validate_length_of(:password).is_at_least(6) }

  it { expect(user).to have_secure_password }

  context 'when has role 1' do
    it { expect(FactoryGirl.build(:user, :admin)).to be_admin }
  end

  context 'when is saved' do
    it 'downcases email' do
      user.email = user.email.upcase
      user.save
      expect(user.email).to eq user.email.downcase
    end
  end

  context 'when is created' do
    it 'creates a passport' do
      new_user = FactoryGirl.create(:user)
      expect(new_user.passport).to be_truthy
    end
  end
end
