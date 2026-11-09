get "/add-product" do
  @product = Products.new
  erb :addProduct
end

post "/add-beans" do

  #image needs to be added to public file

  if params["image"]
    file_name = params["image"][:filename]
    file_content = params["image"][:tempfile]
    file_destination = "./public/#{file_name}"

    File.open(file_destination, 'wb') do |file|
      file.write(file_content.read)
    end
  end

  @products = Products.new
  @stock = Stock.new
  @bean = Beans.new


  @products.load(params.merge("image" => file_name), 0)
  @bean.load(params)
  @stock.load(params)

  if @products.valid?
    @products.save # change to valid after test

    @bean.product_id = @products.product_id
    @bean.save

    @stock.product_id = @products.product_id
    @stock.save

    redirect "/add-product"
    
  else
    erb :addProduct
  end
end

post "/add-coffee" do

  #image needs to be added to public file

  if params["image"]
    file_name = params["image"][:filename]
    file_content = params["image"][:tempfile]
    file_destination = "./public/#{file_name}"

    File.open(file_destination, 'wb') do |file|
      file.write(file_content.read)
    end
  end

  @products = Products.new
  @stock = Stock.new


  @products.load(params.merge("image" => file_name), 1)
  @stock.load(params)

  if @products.valid?
    @products.save # change to valid after test

    @stock.product_id = @products.product_id
    @stock.save

    redirect "/add-product"
    
  else
    erb :addProduct
  end
end