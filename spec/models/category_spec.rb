require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to have_many(:beers) }

  it { expect(FactoryGirl.build(:category, name: nil)).to validate_presence_of(:name) }

  context 'when it has beer' do
    it "can't be deleted" do
      category = FactoryGirl.create(:category)
      FactoryGirl.create(:beer, category: category)
      expect(category.destroy).to be_falsey
    end
  end

  context "when it hasn't beer" do
    it 'can be deleted' do
      category = FactoryGirl.create(:category)
      expect(category.destroy).to be_truthy
    end
  end
end
