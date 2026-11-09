require_relative '../helpers/validation'

class AccountStatus < Sequel::Model(:AccountStatus)
  include Validation
  extend Validation

  def set()
    
    self.status = "active"
    self.given_warning = false

  end

end