get '/admin/orders' do
  # Only admins (type 2) can access this page
  halt 403, 'Access denied' unless session[:account_type] == 2

  @orders = Order.all
  @logs = AuditLog.all

  erb :"admin/orders"
end

post '/admin/orders/:id/update_payment' do
  halt 403, 'Access denied' unless session[:account_type] == 2

  order = Order[params[:id].to_i]
  halt 404, 'Order not found' unless order

  reason = params.fetch('reason', '').strip
  new_status = params.fetch('payment', '').strip

  if reason.empty?
    @error = 'A reason is required to update payment status.'
    @orders = Order.all
    @logs = AuditLog.all
    halt erb(:"admin/orders")
  end

  AuditLog.record(
    order_number: order.order_number,
    admin_account: session[:account_number],
    old_status: order.payment,
    new_status: new_status,
    reason: reason
  )

  order.update(payment: new_status)

  redirect '/admin/orders'
end

get '/manager/sales' do
  halt 403, 'Access denied' unless [1, 2].include?(session[:account_type])

  @coffees = Order.coffees_by_type
  @beans = Order.beans_by_type
  @free_coffees = Order.free_coffees_redeemed

  erb :"manager/sales"
end

get '/manager/membership' do
  halt 403, 'Access denied' unless [1, 2].include?(session[:account_type])

  @total_members = Account.total_members
  @signups = Account.monthly_signups

  erb :"manager/membership"
end

get '/manager/accounts' do
  # Only allow managers (type 1) and admins (type 2)
  halt 403, 'Access denied' unless [1, 2].include?(session[:account_type])

  @accounts = Account.all
  @account_statuses = AccountStatus.all

  erb :"manager/accounts"
end
