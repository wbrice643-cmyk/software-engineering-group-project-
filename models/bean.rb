class Beans < Sequel::Model
  include Validation
  extend Validation

  def load(params)
    origin = params.fetch("origin", "").strip
    roast_level = params.fetch("roast_level", "").strip
    weight = params.fetch("weight", "").strip

    self.origin = origin
    self.roast_level = roast_level
    self.weight = weight
  end

  def validate
    super
    errors.add("origin", "cannot be empty") if !origin || origin.empty?
    errors.add("roast_level", "cannot be empty") if !roast_level || roast_level.empty?
    errors.add("weight", "cannot be empty") if !roast_level
  end
end