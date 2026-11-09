RSpec.describe Stock do

  describe "Adding Beans to Stock" do
    context "Stock id is same to the product id" do
      it "both are linked" do

        spec_before()

        product = add_test_product_to_db()
        stock = Stock[product.product_id]

        expect(product.product_id).to eq(stock.product_id)

      end 
    end

    context "adding the stock" do
      it "stock is added" do

        spec_before()

        product = add_test_product_to_db()
        stock = Stock[product.product_id]

        expect(stock.product_id).to eq(1)

      end 
    end 
  end
end