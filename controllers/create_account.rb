get "/create-account" do
  @accounts = Account.new
  erb :admin_create_account
end

post "/create-account" do
  
  @accounts = Account.new
  @accounts.load(params)

  if @accounts.valid?
    @accounts.save # change to valid after test

    @accountStatus = AccountStatus.new
    @accountStatus.set
    @accountStatus.account_number = @accounts.account_number
    @accountStatus.save 

    redirect "/"
  else
    erb :admin_create_account
  end
end