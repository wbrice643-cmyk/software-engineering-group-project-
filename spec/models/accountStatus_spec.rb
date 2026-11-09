RSpec.describe AccountStatus do
  describe "#set" do
    it "set record" do

      account = add_test_account_to_db()
      status = described_class[account.account_number]

      expect(status.status).to eq("active")
      expect(status.given_warning).to eq(false)
    end
  end
end