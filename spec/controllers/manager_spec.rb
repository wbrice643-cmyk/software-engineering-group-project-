RSpec.describe "Manager and Admin routes" do

  # ───── GET /admin/orders ─────────────────────────────────────────────────

  describe "GET /admin/orders" do
    context "when not logged in" do
      it "returns 403 Access Denied" do
        get "/admin/orders"
        expect(last_response.status).to eq(403)
      end
    end

    context "when logged in as a customer (account_type 3)" do
      it "returns 403 Access Denied" do
        get "/admin/orders", {}, { "rack.session" => { account_type: 3 } }
        expect(last_response.status).to eq(403)
      end
    end

    context "when logged in as a manager (account_type 1)" do
      it "returns 403 Access Denied" do
        get "/admin/orders", {}, { "rack.session" => { account_type: 1 } }
        expect(last_response.status).to eq(403)
      end
    end

    context "when logged in as an admin (account_type 2)" do
      it "returns 200 and displays the orders page" do
        get "/admin/orders", {}, { "rack.session" => { account_type: 2 } }
        expect(last_response).to be_ok
        expect(last_response.body).to include("Order Payment Correction")
      end
    end
  end

  # ───── POST /admin/orders/:id/update_payment ─────────────────────────────

  describe "POST /admin/orders/:id/update_payment" do
    context "when not logged in" do
      it "returns 403 Access Denied" do
        post "/admin/orders/1/update_payment", { payment: "Paid", reason: "test" }
        expect(last_response.status).to eq(403)
      end
    end

    context "when logged in as admin and reason is missing" do
      it "re-renders the page with an error message" do

        add_test_order_to_db(1, 1, "Unpaid", "2026-05-17")

        post "/admin/orders/1/update_payment",
             { payment: "Paid", reason: "" },
             { "rack.session" => { account_type: 2, account_number: 1 } }

        expect(last_response.body).to include("reason is required")
      end
    end

    context "when logged in as admin with a valid reason" do
      it "updates the order payment and redirects" do

        add_test_order_to_db(1, 1, "Unpaid", "2026-05-17")

        post "/admin/orders/1/update_payment",
             { payment: "Paid", reason: "Customer paid in person" },
             { "rack.session" => { account_type: 2, account_number: 1 } }

        expect(last_response).to be_redirect
        expect(Order[1].payment).to eq("Paid")
      end
    end
  end

  # ───── GET /manager/sales ─────────────────────────────────────────────────

  describe "GET /manager/sales" do
    context "when not logged in" do
      it "returns 403 Access Denied" do
        get "/manager/sales"
        expect(last_response.status).to eq(403)
      end
    end

    context "when logged in as a customer (account_type 3)" do
      it "returns 403 Access Denied" do
        get "/manager/sales", {}, { "rack.session" => { account_type: 3 } }
        expect(last_response.status).to eq(403)
      end
    end

    context "when logged in as a manager (account_type 1)" do
      it "returns 200 and displays the sales page" do
        get "/manager/sales", {}, { "rack.session" => { account_type: 1 } }
        expect(last_response).to be_ok
        expect(last_response.body).to include("Sales")
      end
    end

    context "when logged in as an admin (account_type 2)" do
      it "returns 200 and displays the sales page" do
        get "/manager/sales", {}, { "rack.session" => { account_type: 2 } }
        expect(last_response).to be_ok
        expect(last_response.body).to include("Sales")
      end
    end
  end

  # ───── GET /manager/membership ────────────────────────────────────────────

  describe "GET /manager/membership" do
    context "when not logged in" do
      it "returns 403 Access Denied" do
        get "/manager/membership"
        expect(last_response.status).to eq(403)
      end
    end

    context "when logged in as a manager (account_type 1)" do
      it "returns 200 and displays the membership page" do
        get "/manager/membership", {}, { "rack.session" => { account_type: 1 } }
        expect(last_response).to be_ok
        expect(last_response.body).to include("Membership")
      end
    end
  end

  # ───── GET /manager/accounts ─────────────────────────────────────────────

  describe "GET /manager/accounts" do
    context "when not logged in" do
      it "returns 403 Access Denied" do
        get "/manager/accounts"
        expect(last_response.status).to eq(403)
      end
    end

    context "when logged in as a manager (account_type 1)" do
      it "returns 200 and displays the accounts page" do
        get "/manager/accounts", {}, { "rack.session" => { account_type: 1 } }
        expect(last_response).to be_ok
        expect(last_response.body).to include("Account")
      end
    end
  end

end
