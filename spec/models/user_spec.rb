require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a name, email, and password' do
    user = User.new(
      name: "Test rspec",
      email: "rspec@gmail.com",
      password: "123456"
    )
    expect(user).to be_valid
  end
  it 'is invalid without a name' do
    user = FactoryGirl.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end
  it 'is invalid without an email address' do
    user = FactoryGirl.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end
  it 'is invalid with a duplicate email address' do
    FactoryGirl.create(:user, email: "test@gmail.com")
    user = FactoryGirl.build(:user, email: "test@gmail.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "has a valid factory" do
    expect(FactoryGirl.build(:user)).to be_valid
  end


end
