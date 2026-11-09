require "bcrypt"
require 'date'

require_relative "../helpers/security"

class Account < Sequel::Model
  include Validation
  extend Validation

  def name
    "#{first_name} #{surname}"
  end
  
  #for adding more customers from the website into the db
  def load(params) 
    first_name = params.fetch("first_name", "").strip
    surname = params.fetch("surname", "").strip
    text_password = params.fetch("password", "").strip
    email = params.fetch("email", "").strip
    phone_number = params.fetch("phone_number", "").strip
    account_type = params.fetch("account_type", "").strip

    self.first_name = first_name
    self.surname = surname 
    self.hash_password = text_password
    self.email = email
    self.phone_number = phone_number

    self.account_creation = self.class.getCurrentDate
    self.last_used = self.class.getCurrentDate

    if account_type.nil? or account_type == ""
      self.account_type = 3
    else
      self.account_type = account_type
    end
  end

  # if all of the data fields aren't full record will not be saved
  def validate
    super
    errors.add("first_name", "cannot be empty") if !first_name || first_name.empty?
    errors.add("surname", "cannot be empty") if !surname || surname.empty?
    errors.add("encrypted_email", "cannot be empty") if !encrypted_email || encrypted_email.empty?
    errors.add("encrypted_phone_number", "cannot be empty") if !encrypted_phone_number || encrypted_phone_number.to_s.empty?
    # Don't need to validate creation time and id
  end

  #is used to assign the date when the user logs into their account
  def getCurrentDate
    self.last_used = DateTime.now().to_date()
  end

  # to get the date for working out sustpension date
  def self.getCurrentDate
    DateTime.now.to_date()
  end

  def hash_password=(plaintext_password)
    self.password_hash = BCrypt::Password.create(plaintext_password)
  end

  def authenticate(password_attempt)
    BCrypt::Password.new(password_hash) == password_attempt
  end

  def email # getter
    Security.decrypt(encrypted_email, encryption_iv_email, encryption_tag_email)
  end

  def email=(plaintext_email) # setter
    result = Security.encrypt(plaintext_email)
    puts Account.columns.inspect
    self.encrypted_email = result[:data]
    self.encryption_iv_email = result[:iv]
    self.encryption_tag_email = result[:tag]
  end

  def phone_number # getter
    Security.decrypt(encrypted_phone_number, encryption_iv_phone, encryption_tag_phone)
  end

  def phone_number=(plaintext_phone_number) # setter
    result = Security.encrypt(plaintext_phone_number)
    puts Account.columns.inspect
    self.encrypted_phone_number = result[:data]
    self.encryption_iv_phone = result[:iv]
    self.encryption_tag_phone = result[:tag]
  end

  # Returns the total number of registered accounts.
  def self.total_members
    Account.count
  end

  # Returns a hash with signup counts for this month, last month, and the change.
  def self.monthly_signups
    now = Time.now
    this_month = now.strftime("%Y-%m")

    # Go to the first of this month, then back one day to land in last month
    first_of_this_month = Time.new(now.year, now.month, 1)
    last_month = (first_of_this_month - 86400).strftime("%Y-%m")

    this_month_count = Account.where(Sequel.like(:account_creation, "#{this_month}%")).count
    last_month_count = Account.where(Sequel.like(:account_creation, "#{last_month}%")).count

    {
      this_month: this_month_count,
      last_month: last_month_count,
      change: this_month_count - last_month_count
    }
  end

end