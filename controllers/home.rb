get "/" do 
  erb :home
end

get "/logout" do
  session.clear
  redirect "/"
end

get "/help-form" do
  erb :help_form
end





