RSpec.describe Order do

  describe ".coffees_by_type" do
    context "when there are coffee products in order items" do
      it "returns a count of each coffee product sold" do

        product = add_test_product_to_db(1, "Flat White", 3.50, "flat_white.png", "A smooth flat white")
        order = add_test_order_to_db(1, 1, "Paid", "2026-05-17")
        add_test_order_item_to_db(1, product.product_id, 3)

        result = Order.coffees_by_type

        expect(result["Flat White"]).to eq(3)
      end
    end

    context "when there are no orders" do
      it "returns an empty hash" do
        result = Order.coffees_by_type
        expect(result).to be_empty
      end
    end

    context "when products are beans (not coffees)" do
      it "does not count bean products" do

        product = add_test_product_to_db(0, "Ethiopian Beans", 8.00, "beans.png", "Light roast")
        order = add_test_order_to_db(1, 1, "Paid", "2026-05-17")
        add_test_order_item_to_db(1, product.product_id, 2)

        result = Order.coffees_by_type

        expect(result).to be_empty
      end
    end
  end

  describe ".beans_by_type" do
    context "when there are bean products in order items" do
      it "returns a count keyed by origin and roast level" do

        # add_test_product_to_db with type 0 internally calls add_bean with
        # defaults: origin="arabic", roast_level="dark"
        product = add_test_product_to_db(0, "Arabic Beans", 8.00, "beans.png", "Dark roast")
        order = add_test_order_to_db(1, 1, "Paid", "2026-05-17")
        add_test_order_item_to_db(1, product.product_id, 2)

        result = Order.beans_by_type

        expect(result["arabic - dark"]).to eq(2)
      end
    end

    context "when there are no orders" do
      it "returns an empty hash" do
        result = Order.beans_by_type
        expect(result).to be_empty
      end
    end

    context "when products are coffees (not beans)" do
      it "does not count coffee products" do

        product = add_test_product_to_db(1, "Flat White", 3.50, "flat_white.png", "A smooth flat white")
        order = add_test_order_to_db(1, 1, "Paid", "2026-05-17")
        add_test_order_item_to_db(1, product.product_id, 2)

        result = Order.beans_by_type

        expect(result).to be_empty
      end
    end
  end

  describe ".free_coffees_redeemed" do
    context "when some orders have payment set to Free" do
      it "returns the correct count of free coffees redeemed" do

        add_test_order_to_db(1, 1, "Free", "2026-05-17")
        add_test_order_to_db(2, 1, "Free", "2026-05-17")
        add_test_order_to_db(3, 1, "Paid", "2026-05-17")

        expect(Order.free_coffees_redeemed).to eq(2)
      end
    end

    context "when no orders have payment set to Free" do
      it "returns zero" do

        add_test_order_to_db(1, 1, "Paid", "2026-05-17")

        expect(Order.free_coffees_redeemed).to eq(0)
      end
    end

    context "when there are no orders at all" do
      it "returns zero" do
        expect(Order.free_coffees_redeemed).to eq(0)
      end
    end
  end

end
