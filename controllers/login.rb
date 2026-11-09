get "/login" do
  redirect "/" if session[:email] # checked if logged in already
  erb :login
end

post "/login" do

  email = params.fetch("email", "").strip
  account_id = -1

  account = Account.all.find do |record|
    decrypted_email = Security.decrypt(record.encrypted_email,record.encryption_iv_email,record.encryption_tag_email)

    if decrypted_email == email
      decrypted_email
    end
  end

  # checks if there is an account logging in, checks password 
  if !account.nil? && account.authenticate(params.fetch("password", ""))
    puts "success"
    session["logged_in"] = true
    session[:account_number] = account.account_number
    session[:account_type] = account.account_type
    account.update(last_used: account.getCurrentDate())

    redirect "/"
  else 
    @error = "Invalid email or password"
  end

  erb :login
end