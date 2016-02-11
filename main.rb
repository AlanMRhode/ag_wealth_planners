require 'sinatra'
require 'mandrill'

get '/' do
	@title = "Home"
  	erb :home
end

get "/about" do
	@title = "About Us"
  	erb :about
end

get "/services" do
	@title = "Our Services"
  	erb :services
end

get "/contact" do
	@title = "Contact Us"
	erb :contact
end

post '/email-request' do
	@firstname = params['first']
	@lastname = params['last']
	@email = params['email']
	@phone = params['phone']
	@description = params['description']
	puts "*************************************************"
	puts "*************************************************"
	puts "*************************************************"
	puts "*************************************************"
	puts params.inspect
	puts "New request from #{@firstname} #{@lastname} just posted"
	puts "*************************************************"
	puts "*************************************************"
	puts "*************************************************"
	puts "*************************************************"

	m = Mandrill::API.new 

	name = "Greg"
	email = "greg@gregorypark.org"
	html = <<-DOC
	 <html>
		<h1>New Client Request from Web Contact Form</h1>
		<h3>Client name: #{@firstname} #{@lastname}</h3>
		<h3>email: #{@email}</h3>
		<h3>phone number: #{@phone}</h3>
		<h3>Details:</h3>
		<p>#{@description}</p>
		</html>
		DOC
	message = {
		:subject => "New Client Inquiry to A.G. Wealth Partners", 
		:from_name => name,  
		:to => [{:email => "gregoryjpark@gmail.com", :name => "Greg"}], 
		:html => html, 
		:from_email => email 
	} 

	puts "SENDING MAIL!"
	sending = m.messages.send message
	puts sending
	puts "PROCESS COMPLETE!"	
	
	erb :home
end


