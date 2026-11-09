RSpec.describe Account do

  describe "#name" do
    context "Account name is displays as first_name surname" do
      it "name is correctly given" do

        account = add_test_account_to_db("John", "Smith")

        expect(account.name).to include("John Smith")
      end
    end
  end

  describe "#load" do
    it "Loads the Account data with the proper encryption" do
      account = described_class.new
      signup_info = { "first_name" => "John", "surname" => "Smith", "text_password" => "password", 
                      "email" => "john@smith.com", "phone_number" => "01234567890", "account_type" => "3",
                      "account_creation" => "2025-10-10", "last_used" => "2020-20-10"}

      expect(account.load(signup_info)).to be_truthy
    end
  end

  describe "#getCurrentDate" do
    it "current date is given" do
    
      account = described_class.new
      current_date = DateTime.now.to_date
      account.getCurrentDate
      expect(account.last_used).to eq(current_date)

    end
  end

  describe "#hash_passord" do
    context "setting the password" do
      it "hashes the password" do

        account = described_class.new
        account.hash_password = "password"

        expect(account.password_hash).not_to eq("password")
      end
    end
  end

  describe "#authenticate" do
    context "authenticates the password" do
      it "authenticate" do

        account = described_class.new
        account.hash_password = "password"

        expect(account.authenticate("password")).to be_truthy
        expect(account.authenticate("wrong_password")).to be_falsy

      end
    end
  end

  describe "#email" do

    context "getting the email and decrypting it"do
      it "get email"do

        account = described_class.new
        account.email = "test@test.com"

        expect(account.email).to eq("test@test.com")

      end
    end

    context "encypting the email address" do
      it "set email" do

        account = described_class.new
        account.email = "test@test.com"

        expect(account.encrypted_email).to_not eq("test@test.com")
      end
    end
  end

  describe "#phone number" do

    context "getting the phone number and decrypting it"do
      it "get phone number"do

        account = described_class.new
        account.phone_number = "01234567890"

        expect(account.phone_number).to eq("01234567890")

      end
    end

    context "encypting the phone number address" do
      it "set phone number" do

        account = described_class.new
        account.phone_number = "01234567890"

        expect(account.encrypted_phone_number).to_not eq("01234567890")
      end
    end
  end

  describe "#number of members" do
    it "gets total number of members" do

      spec_before()

      customer_one = add_test_account_to_db("John" , "smith")
      customer_two = add_test_account_to_db("Dan" , "smith")

      expect(Account.count).to eq(2)
    end
  end

  describe "#Monthly number of members" do
    it "returns the monthly number of members" do

      spec_before()

      customer_one = add_test_account_to_db("test", "test", "password", 0, Account.getCurrentDate.prev_month)
      customer_two = add_test_account_to_db("test", "test", "password", 0, Account.getCurrentDate)
      customer_three = add_test_account_to_db("test", "test", "password", 0, Account.getCurrentDate)

      sign_up = Account.monthly_signups

      expect(sign_up).to eq({change: 1, last_month: 1, this_month: 2})
    end
  end
end
