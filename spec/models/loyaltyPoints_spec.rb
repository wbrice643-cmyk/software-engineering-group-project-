RSpec.describe LoyaltyPoints do
  describe "Set Points" do
    it "0 Point on creation" do

      account = add_test_account_to_db("John", "Smith")

      points = LoyaltyPoints[account.account_number]

      expect(points.points).to eq(0)
      
    end
  end
end