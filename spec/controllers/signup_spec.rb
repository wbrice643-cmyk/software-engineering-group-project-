RSpec.describe "signup" do
  context "when the page is visited" do
    it "loads correct" do
      get "/signup"
      expect(last_response.status).to eq(200)
    end
  end
end