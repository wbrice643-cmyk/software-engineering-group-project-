get "/product-database" do
  @name_search = params.fetch("name_search", "").strip

  @beans = Beans.all
  @stock = Stock.all

  @products = if @name_search == ""
                Products.all
              else
                Products.where(Sequel.ilike(:name, "%#{@name_search}"))
              end
  erb :product_db
end

post "/delete-product" do
  
  product_id = params[:product_id]
  product = Products[product_id]
  
  if product

    product.delete

    redirect "/product-database"
  end

  erb :product_db
end

post "/set-stock" do 

  product_id = params[:product_id]
  product = Products[product_id]

  if product && product.product_id

    stock = Stock[product.product_id]

    if stock

      stock.update(stock: params[:set_stock])

    end
  end

  redirect "/product-database"
end