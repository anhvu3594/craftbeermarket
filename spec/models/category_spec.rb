require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to have_many(:beers) }

  it { expect(FactoryGirl.build(:category, name: nil)).to validate_presence_of(:name) }
end
