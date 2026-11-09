RSpec.describe "help form" do
  context "when the page is visited" do
    it "loads correct" do
      get "/help-form"
      expect(last_response.status).to eq(200)
    end
  end
end