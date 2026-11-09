class AuditLog < Sequel::Model(:AuditLog)
  # Records a payment status change made by an admin.
  # Called whenever an admin updates an order's payment status.
  def self.record(order_number:, admin_account:, old_status:, new_status:, reason:)
    AuditLog.create(
      order_number: order_number,
      admin_account: admin_account,
      old_status: old_status,
      new_status: new_status,
      reason: reason
    )
  end
end
