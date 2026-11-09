# need to include the load to have foreign keys activated in the read me
class Products < Sequel::Model
  include Validation
  extend Validation

  def load(params, product_type)
    name = params.fetch("name", "").strip
    price = params.fetch("price", "").strip
    image = params.fetch("image", "").strip
    description = params.fetch("description", "")

    self.name = name
    self.price = price
    self.image = image
    self.product_type = product_type
    self.description = description
  end

  def validate
    super
    errors.add("name", "cannot be empty") if !name || name.empty?
    errors.add("price", "cannot be empty") if !price
    errors.add("product_type", "cannot be empty") if !product_type
  end

end