RSpec.describe Orders do

  describe "load order" do
    it "Adds correctly" do
      spec_before()
      
      orders = add_test_order_to_db(1,1,"Online","2026-05-15")
      expect(orders.order_number).to eq(1)
    end
  end

end
