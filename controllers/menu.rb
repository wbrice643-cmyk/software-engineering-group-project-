get "/menu" do

  @products = Products.all 
  @beans = Beans.all
  @stock = Stock.all

  erb :menu
end