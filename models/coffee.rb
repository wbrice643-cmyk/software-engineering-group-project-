class Coffee < Sequel::Model
  include Validation
  extend Validation

  def load(params)
    milk = params.fetch("milk", "").strip
    size = params.fetch("size", "").strip

    self.milk = milk
    self.size = size
  end

  def validate
    super
    errors.add("milk", "cannot be empty") if !first_name || first_name.empty?
    errors.add("size", "cannot be empty") if !surname || surname.empty?
  end
end