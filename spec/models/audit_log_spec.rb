RSpec.describe AuditLog do

  describe ".record" do
    context "when called with valid arguments" do
      it "creates a new audit log entry in the database" do

        add_test_order_to_db(1, 1, "Unpaid", "2026-05-17")

        AuditLog.record(
          order_number:  1,
          admin_account: 1,
          old_status:    "Unpaid",
          new_status:    "Paid",
          reason:        "Customer paid at counter"
        )

        expect(AuditLog.count).to eq(1)
      end
    end

    context "checking the saved values" do
      it "stores the correct order number, statuses, and reason" do

        add_test_order_to_db(1, 1, "Unpaid", "2026-05-17")

        AuditLog.record(
          order_number:  1,
          admin_account: 1,
          old_status:    "Unpaid",
          new_status:    "Paid",
          reason:        "Customer paid at counter"
        )

        log = AuditLog.first

        expect(log.order_number).to eq(1)
        expect(log.old_status).to eq("Unpaid")
        expect(log.new_status).to eq("Paid")
        expect(log.reason).to eq("Customer paid at counter")
      end
    end

    context "when called multiple times" do
      it "creates a separate log entry for each call" do

        add_test_order_to_db(1, 1, "Unpaid", "2026-05-17")

        AuditLog.record(
          order_number:  1,
          admin_account: 1,
          old_status:    "Unpaid",
          new_status:    "Paid",
          reason:        "First correction"
        )

        AuditLog.record(
          order_number:  1,
          admin_account: 1,
          old_status:    "Paid",
          new_status:    "Pay in Store",
          reason:        "Second correction"
        )

        expect(AuditLog.count).to eq(2)
      end
    end
  end

end
