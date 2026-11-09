require 'spec_helper'

RSpec.describe "addProduct" do
  describe "GET /addProduct" do
    it "displays forms" do
      get "/add-product"
      expect(last_response).to be_ok
      expect(last_response.body).to include("header")
    end
  end

  describe "POST /add-beans" do
    context "when all params are valid" do
      it "add the beans product" do

        test_path = __FILE__
        test_image = Rack::Test::UploadedFile.new(test_path, 'image/png')

        params ={
          "product_type" => 0, 
          "name" => "Ethiopian Beans", 
          "price" => 13.99,
          "description" => "Hard Roasted", 
          "origin" => "ethiopian", 
          "roast_level" => "dark", 
          "weight" => 300, 
          "stock" => 100,
          "image" => test_image
        }

        post "/add-beans",params

        controller_output = "./public/addProduct_spec.rb"
        File.delete(controller_output) if File.exist?(controller_output)

        product = Products.last
        expect(product.name).to eq("Ethiopian Beans")
      end
    end
  end

  describe "POST /add-coffee" do
    context "when all params are valid" do
      it "add the coffee product" do

        test_path = __FILE__
        test_image = Rack::Test::UploadedFile.new(test_path, 'image/png')

        params ={
          "product_type" => 0, 
          "name" => "Black Coffee", 
          "price" => 3.99,
          "description" => "Hard Roasted", 
          "stock" => 100,
          "image" => test_image
        }

        post "/add-coffee",params

        controller_output = "./public/addProduct_spec.rb"
        File.delete(controller_output) if File.exist?(controller_output)

        product = Products.last
        expect(product.name).to eq("Black Coffee")
      end
    end
  end
end