get "/orders-DB" do
  @user = Account[session[:account_number]]
  @order_Number = params.fetch("order_Number", "").strip

  if session["logged_in"] && @user.account_type == 3 
      @orders = Orders.where(Sequel.ilike(:account_number, @user.account_number))
  else
      @orders = if @order_Number.empty?
               Orders.all
             else
               Orders.where(Sequel.ilike(:order_number, "%#{@order_Number}%"))
             end
  end
  erb :orders_DB
end

get "/order_page" do

  @products = Products.all 
  @beans = Beans.all
  @stock = Stock.all

  session[:order] ||= []
  @order_items = session[:order]
  @total = @order_items.sum { |item| item[:price] * item[:items_payed] }
  erb :order_page
end

post "/order/add" do

  #make sure a user is logged in
  if session["logged_in"] == nil || session["logged_in"] == false
    redirect "/login"
  end

  points = LoyaltyPoints[session[:account_number]]

  session[:stock_error] = nil
  session[:order] ||= []
  session[:total_points] ||= points.points
  session[:discounts] ||= 0
  name = params[:name]
  price = params[:price].to_f
  qty = params[:qty].to_i
  milk = params[:milk]
  size = params[:size]

  #finding the product id
  product = Products.all.find do |product|
    if name == product.name
      product
    end
  end


  stock = Stock[product_id: product.product_id]

  if (stock.stock >= qty)
    stock.update(stock: stock.stock - qty)
  else

    session[:stock_error] = "There are only " + stock.stock.to_s + " left in stock"
    redirect "/order_page"
  end


    #finding the total number of loyaltyPoints gained in current purchase
  points = 0

  # 3 points for beans
  if product.product_type == 0
    points += 3
  end 

  # only 1 point for coffee
  if product.product_type == 1
    points += 1
  end  

  session[:total_points] += points * qty

  existing = session[:order].find { |item| item[:name] == name}

  if existing
    existing[:qty] += qty
    existing[:items_payed] += qty
    puts "when addded"
    puts existing[:items_payed]
  else
    session[:order] << { 
      name: name, 
      price: price, 
      qty: qty, 
      milk: milk, 
      size: size, 
      id: product.product_id, 
      points: points,
      items_payed: qty
    }
  end

  all_orders = session[:order]

  # sets the lowest item in order to be free
  if session[:total_points] >= 10 || session[:discounts] > 0

    
    if session[:total_points] >= 10

      session[:discounts] += 1
      session[:total_points] -= 10
    end

    #resets all the discounts, So new ones can be applied
    all_orders.each do |item|
      item[:items_payed] = item[:qty]
    end

    lowest_price = all_orders.min_by { |item| item[:price]}
    actual_price = lowest_price[:price]

    discounts_applied = 0
    while session[:discounts] > discounts_applied

      # doesnt have discount
      if lowest_price[:qty] == lowest_price[:items_payed]

        lowest_price[:items_payed] -= 1
        puts "Item to be Paid:"
        puts lowest_price[:items_payed]
        puts session[:discounts]

      elsif lowest_price[:items_payed] != 0 && session[:discounts] > discounts_applied 

        lowest_price[:items_payed] -= 1
        puts "Item to be Paid:"
        puts lowest_price[:items_payed]
        puts session[:discounts]

        #finding the next lowest
      else 
        lowest_price = all_orders.select {|item| item[:price] > actual_price}
        lowest_price = lowest_price.min_by {|item| item[:price]}
        actual_price = lowest_price[:price]
        lowest_price[:items_payed] -= 1

      end

      discounts_applied += 1
    end
  end

  redirect "/order_page#summary"
end


post "/order/remove" do 

  session[:order] ||= []
  cart_item = session[:order].find { |item| item[:name] == params[:name] }

  if cart_item.nil? 
    redirect "/order_page#summary"

  else
    product = Products[cart_item[:id]] 
    qty = cart_item[:qty]

    # Removing the loyalty point
    points = 0

    # 3 points for beans
    if product.product_type == 0
      points -= 3 * qty
    end 

    # 1 point for coffee
    if product.product_type == 1
      points -= 1 * qty
    end  

    #points is negative
    session[:total_points] += points


    stock = Stock[product_id: product.product_id]
    puts stock.stock
    stock.update(stock: stock.stock + qty)

    puts stock.stock

    session[:order] ||= []
    session[:order].reject! { |item| item[:name] == params[:name] }
    redirect "/order_page#summary"
  end
end

post "/order/checkout" do
  @order_items = session[:order]
  @total = @order_items.sum { |item| item[:price] * item[:items_payed] }
  @payment = params[:payment]

  order = Order.create(
    account_number: session[:account_number],
    payment: @payment,
    date: Account.getCurrentDate
  )

  order_number = order.order_number

  @order_items.each do |item| 
    OrderItems.create(
      order_number: order_number,
      product_id: item[:id],
      qty: item[:qty],
      free_items: item[:qty] - item[:items_payed]
    )
  end

  loyalty = LoyaltyPoints[session[:account_number]]
  loyalty.update(points: session[:total_points])

  session[:order] = []
  session[:discounts] = 0

  if @payment == "Paid"
    redirect "https://www.stripe.com"
  else
    erb :order_confirmation
  end
end
