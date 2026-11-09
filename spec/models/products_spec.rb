RSpec.describe Products do

  describe "adding a product to DB" do
    it "adds correctly" do
    
      spec_before()

      product = add_test_product_to_db()

      expect(product.product_id).to eq(1)

    end 
  end

end