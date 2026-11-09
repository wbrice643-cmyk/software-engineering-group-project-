get "/customer-database" do

  @account = Account.all
  @accountStatus = AccountStatus.all
  @loyaltyPoints = LoyaltyPoints.all

  suspension_date = Account.getCurrentDate()
  suspension_date = suspension_date << 6

  warning_date = Account.getCurrentDate()
  warning_date = suspension_date + 5

  # Check which accounts need to be flagged for inactivity 
  @account.each do |acc| 

    account_status = AccountStatus[acc.account_number]

    if account_status

      # Warning for Suspension, An example Email will be sent to the terminal
      if acc.last_used <= warning_date && account_status.given_warning == false

        account_status.update(status: "warning")
        account_status.update(given_warning: true)

        Pony.mail(
          :to      => acc.email,
          :from    => 'badlybrewed@coffee.com',
          :subject => 'Account Suspension Notice',
          :body    => 'Your Account is at risk of being suspened. Please Login within 5 days or it will be suspened',
          :via     => :logger
          )
      end


      if  acc.last_used <= suspension_date && account_status.given_warning == true
        account_status.update(status: "suspended")
      end

      if account_status.given_warning == true && acc.last_used > warning_date
        account_status.update(given_warning: false)
        account_status.update(status: "active")
      end
    end
  end


  @id_search = params.fetch("id_search", "").strip

  @accounts = if @id_search.empty?
               Account.all
             else
               Account.where(Sequel.ilike(:account_number, "%#{@id_search}%"))
             end
  erb :customer_DB
end

post "/delete-account-c" do
  
  account_number = params[:account_number]
  account = Account[account_number]
  
  if account
    account.delete
  end
  redirect "/customer-database"
end



post "/add-point" do 

  account_number = params[:account_number]
  point = LoyaltyPoints[account_number]

  if point
    point.update(points: point.points + 1)
  end

  redirect "/customer-database"
end

