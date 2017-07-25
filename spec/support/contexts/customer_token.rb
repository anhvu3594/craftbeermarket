RSpec.shared_context "customer token" do
  let!(:customer) { FactoryGirl.create(:user) }
  let!(:token) { (FactoryGirl.create(:token, user_id: customer.id)).access_token }
end
