class LoyaltyPoints < Sequel::Model(:LoyaltyPoints)
  include Validation
  extend Validation

  def set()
    self.points = 0
  end

end