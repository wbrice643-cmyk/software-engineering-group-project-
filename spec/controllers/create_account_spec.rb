RSpec.describe "Creating Account" do
  describe "GET /create-account" do
    it "displays header" do
      get "/create-account"
      expect(last_response).to be_ok
      expect(last_response.body).to include("header")
    end
  end

  describe "GET /create-account" do
    context "Display all forms" do
      it "Company name" do
        get "/create-account" do
        
          expect(last_response).to be_ok
          expect(last_response.body).to include("Badly Brewed Coffee")

        end
      end
    end

    context "all fill in forms" do
      it "Dispay all forms" do
        get "/create-account"

        spec_before()

        page = last_response.body

        expect(page).to include('placeholder = "First Name"')
        expect(page).to include('placeholder = "Second Name"')
        expect(page).to include('placeholder = "Email"')
        expect(page).to include('placeholder = "Phone Number"')
        expect(page).to include('placeholder = "Password"')
        expect(page).to include('value = "Create Account"')
        
      end
    end
  end

  describe "Adding account" do
    context "Adding account types" do
      it "adding barista" do

        spec_before()

        num_of_accounts = Account.count

        post "/create-account", {
              "first_name" => "test",
              "surname" => "test",
              "text_password" => "password",
              "email" => "test@test.com", 
              "phone_number" => "01234567890",
              "account_type" => "0"

            }

        account = Account.all.last

        expect(Account.count).to eq(num_of_accounts + 1)
        expect(account.account_type).to eq(0)

      end
      it "adding manager" do

        spec_before()

        num_of_accounts = Account.count

        post "/create-account", {
              "first_name" => "test",
              "surname" => "test",
              "text_password" => "password",
              "email" => "test@test.com", 
              "phone_number" => "01234567890",
              "account_type" => "2"

            }

        account = Account.all.last

        expect(Account.count).to eq(num_of_accounts + 1)
        expect(account.account_type).to eq(2)

      end
      it "adding admin" do

        spec_before()

        num_of_accounts = Account.count

        post "/create-account", {
              "first_name" => "test",
              "surname" => "test",
              "text_password" => "password",
              "email" => "test@test.com", 
              "phone_number" => "01234567890",
              "account_type" => "3"

            }

        account = Account.all.last

        expect(Account.count).to eq(num_of_accounts + 1)
        expect(account.account_type).to eq(3)

      end
    end
  end



    
end