class Stock < Sequel::Model(:Stock)
  include Validation
  extend Validation

  def load(params)
    stock = params.fetch("stock", "").strip.to_i

    self.stock = stock
  end

  def validate
    super
    errors.add("stock", "cannot be empty") if !stock
  end
end