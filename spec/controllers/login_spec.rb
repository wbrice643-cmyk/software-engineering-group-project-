RSpec.describe "login" do

  describe "Displays Header" do
    it "displays" do

      get "/login"
      expect(last_response).to be_ok
      expect(last_response.body).to include("header")

    end
  end

  describe "GET /login" do
    context "login page is displaying" do
      it "displays" do

      get "/login"
      expect(last_response).to be_ok
      expect(last_response.body).to include("Login")
      expect(last_response.body).to include("Sign Up")
      expect(last_response.body).to include('placeholder = "Enter Email"')
      expect(last_response.body).to include('placeholder = "Password"')
      expect(last_response.body).to include("Sign In")

      end
    end
  end

  describe "POST /login" do
    context "Account Login" do
      it "email is found" do

        spec_before()

        post "/login", {email: "customer@test.com", password: "password"}

        expect(last_response.body).to_not include("Invalid email or password")
      
      end

      it "Email is Not Found" do

        spec_before()

        post "/login", {email: "invalid@email.com", password: "password"}

        expect(last_response).to_not be_redirect

      end

      it "Login" do

        post "/login", {email: "customer@test.com", password: "password"}

        expect(last_response).to be_redirect

      end
    end
  end
end