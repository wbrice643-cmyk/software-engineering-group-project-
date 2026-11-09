class Orders < Sequel::Model
  include Validation
  extend Validation

  def load(params)
    order_number = params.fetch("order_number", "").strip
    account_number = params.fetch("account_number", "").strip
    payment = params.fetch("payment", "").strip
    date = params.fetch("date", "").strip

    self.order_number = order_number
    self.account_number = account_number
    self.payment = payment
    self.date = date
  end

 
end