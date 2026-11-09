get "/signup" do
  @accounts = Account.new
  erb :signup
end

post "/signup" do

  @accounts = Account.new
  @accounts.load(params)

  if @accounts.valid?

    @accounts.save

    @accountStatus = AccountStatus.new
    @accountStatus.set
    @accountStatus.account_number = @accounts.account_number
    @accountStatus.save

    @loyaltyPoints = LoyaltyPoints.new
    @loyaltyPoints.set
    @loyaltyPoints.account_number = @accounts.account_number
    @loyaltyPoints.save

    redirect "/"
  else
    erb :signup
  end
end