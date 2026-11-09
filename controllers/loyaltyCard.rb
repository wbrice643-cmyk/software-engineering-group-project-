get "/loyalty-card" do

  @loyaltyPoints = LoyaltyPoints.all

  points = LoyaltyPoints[session[:account_number]]

  if points

    puts points.points
    
  end

  erb :loyalty_card
end