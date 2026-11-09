RSpec.describe "Menu Page" do
    
    describe "GET /menu" do
        context "when the page is visited" do
            it "loads successfully" do
                get "/menu"
                expect(last_response.status).to eq(200)
                expect(last_response.body).to include("Menu")
                expect(last_response.body).to include("A perfect start to your day")
            end
        end
        
        context "when products exist in database" do
            it "displays coffee products" do
                get "/menu"
                # Check for product names (assuming you have test data)
                expect(last_response.body).to include("Latte")
                expect(last_response.body).to include("Black Coffee")
            end
            
            it "displays product prices" do
                get "/menu"
                expect(last_response.body).to match(/£\d+\.\d{2}/)
            end
        end
        
        context "when displaying add-ons" do
            it "shows add-ons section" do
                get "/menu"
                expect(last_response.body).to include("Add-ons")
                expect(last_response.body).to include("Extra Shot")
                expect(last_response.body).to include("+£0.80")
                expect(last_response.body).to include("Oat Milk")
                expect(last_response.body).to include("+£0.50")
            end
        end
    end
    
    describe "GET /css/menu.css" do
        context "when the CSS file is requested" do
            it "loads successfully" do
                get "/css/menu.css"
                expect(last_response.status).to eq(200)
            end
            
            it "has correct content type" do
                get "/css/menu.css"
                expect(last_response.content_type).to include("text/css")
            end
        end
    end
    
end