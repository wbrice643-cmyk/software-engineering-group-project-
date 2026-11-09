RSpec.describe Beans do
  describe "#load"do
    it "testing it loads correctly" do

      spec_before()

      product = add_test_product_to_db(0)
      bean = Beans[product.product_id]

      expect(bean.product_id).to eq(1)
    end
  end

  describe "Beans are linked to a product" do 
    it "they are connected" do

      spec_before()

      product = add_test_product_to_db(0)
      bean = Beans[product.product_id]

      expect(bean.product_id).to eq(product.product_id)


    end 
  end
end