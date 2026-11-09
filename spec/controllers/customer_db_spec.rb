RSpec.describe "Customer Database" do

  describe "GET /customer-database" do
    it "displays a blank form" do
      get "/customer-database"
      expect(last_response).to be_ok
      expect(last_response.body).to include("Customer Database")
    end
  end

  describe "GET /customer-database" do
    it "displays a blank form" do
      get "/customer-database"
      expect(last_response).to be_ok
      expect(last_response.body).to include("Enter the Customer id:")
      expect(last_response.body).to include('type="text"')
      expect(last_response.body).to include('type="submit"')
    end
  end

  describe "GET /customer-database" do
    it "displays a blank form" do
      get "/customer-database"
      expect(last_response).to be_ok
      expect(last_response.body).to include("Enter the ID of the Account to be deleted:")
      expect(last_response.body).to include('type="text"')
      expect(last_response.body).to include('type="submit"')
    end
  end

  describe "GET /customer-database" do
    it "displays a blank form" do
      get "/customer-database"
      expect(last_response).to be_ok
      expect(last_response.body).to include("Enter the ID of the Account to be added a point:")
      expect(last_response.body).to include('type="text"')
      expect(last_response.body).to include('type="submit"')
    end
  end

  describe "GET /customer-database" do
    context "displays the Customers in the database" do
      it "Finding all accounts" do

        add_test_account_to_db("John", "Smith")
        add_test_account_to_db("Daniel", "Radcliffe")
        get "/customer-database"
        expect(last_response).to be_ok
        expect(last_response.body).to include("John")
        expect(last_response.body).to include("Smith")
        expect(last_response.body).to include("Daniel")
        expect(last_response.body).to include("Radcliffe")
      end
    end

    context "Searching Customer in the database" do
      it "Finding the correct account" do

      customer_one = add_test_account_to_db("Lewis", "Dunk")
      customer_two = add_test_account_to_db("Daniel", "Radcliffe")

      get "/customer-database", "id_search" => customer_one.account_number
      expect(last_response).to be_ok
      expect(last_response.body).to include("Lewis")
      expect(last_response.body).to include("Dunk")
      expect(last_response.body).not_to include("Daniel")
      expect(last_response.body).not_to include("Radcliffe")
      end
    end

    context "Deleting Account" do
      it "Checking if account is deleted" do

      customer_one = add_test_account_to_db("John", "Smith")

      post "/delete-account", "account_number" => customer_one.account_number
      expect(Account.first(account_number: customer_one.account_number)).to be_nil
      end
    end

    context "trying to delete account with invalid number" do
      it "does complains with an error" do

        account = add_test_account_to_db("John", "Smith")

        post "/delete-account", "account_number" => account.account_number + 1

        expect(last_response).to be_redirect
        expect(last_response.location).to include("/customer-database")

      end
    end

    describe " POST /add-point" do
      context "/add-point" do
        it "adding point to customer" do
          
          account = add_test_account_to_db("Lewis", "Dunk")
          points = add_test_points_to_db(account.account_number, 0)

          post "/add-point", "account_number" => account.account_number

          expect(last_response).to be_redirect
          follow_redirect!
      
          expect(last_response).to be_ok
          expect(last_response.body).to include((points.points + 1).to_s)
        end
      end

      context "trying to add points to nil account" do
        it "attempting to add point" do
            account = add_test_account_to_db("Lewis", "Dunk")
            points = add_test_points_to_db(account.account_number, 0)

            post "/add-point", "account_number" => account.account_number + 1

            expect(last_response).to be_redirect
            follow_redirect!
        
            expect(last_response).to be_ok
            expect(last_response.body).to include((points.points).to_s)
        end
      end
    end
  end
end