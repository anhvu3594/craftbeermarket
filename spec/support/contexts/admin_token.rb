RSpec.shared_context "admin token" do
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let!(:token) { (FactoryGirl.create(:token, user_id: admin.id)).access_token }
end
