require 'rails_helper'

RSpec.describe Beer, type: :model do
  it { is_expected.to belong_to(:category) }

  it { is_expected.to have_and_belong_to_many(:passports) }

  it { expect(FactoryGirl.build(:beer, name: nil)).to validate_presence_of(:name) }

  it { expect(FactoryGirl.build(:beer, manufacturer: nil)).to validate_presence_of(:manufacturer) }

  it { expect(FactoryGirl.build(:beer, price: nil)).to validate_presence_of(:price) }

  it { expect(FactoryGirl.build(:beer, category: nil)).to validate_presence_of(:category) }
end
