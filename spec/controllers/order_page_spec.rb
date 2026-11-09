RSpec.describe "Order Page" do
    #include Rack::Test::Methods

    describe "GET /order_page" do

        context "when the page is visited" do
            it "loads succesfully" do
                get "/order_page"
                expect(last_response.status).to eq(200)
                expect(last_response.body).to include("Welcome! What would you like to order?")
            end
        end

        context "session and intial variables are empty" do
          it "creates emtpy order" do
            get "/order_page" 

            expect(last_request.session[:order].size).to eq(0) 

          end

          it "returning to page when item is added previously" do

            account = Account.all.find {|account| account.account_type = "3"}
            
            session = {"logged_in" => true, :account_number => "3"}

            get "/order_page", {}, {'rack.session' => session}

            post "/order/add", "name" => "Matcha Latte", "price" => "3.29", "qty" => "1"

            expect(last_request.session[:order].size).to eq(1)

            get "/order_page"

            expect(last_request.session[:order].size).to eq(1)

          end
        end
    end


    describe "POST /order/add" do

        context "when an item is added to basket" do
            it "redirects back to order page" do
                post "/order/add", "name" => "Matcha Latte", "price" => "3.29", "qty" => "1"
                expect(last_response.status).to eq(302)   #302 is redirect
            end
        end
    end

    describe "POST /order/remove" do

        context "when an item is removed off basket" do
            it "redirects back to order page" do
                post "/order/remove", "name" => "Matcha Latte"
                expect(last_response.status).to eq(302)
            end
        end
    end

end