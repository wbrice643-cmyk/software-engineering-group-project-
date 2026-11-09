RSpec.describe "get order Database" do
  context "when the page is visited" do
    it "loads successfully" do
      get "/orders-DB"
      expect(last_response).to be_ok
      expect(last_response.body).to include("Orders")
    end
  end
end
