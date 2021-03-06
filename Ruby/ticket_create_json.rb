#Create a ticket with cc_emails attributes.
require "rubygems"
require "rest_client"
require "json"

# Your freshdesk domain
fd_domain = 'YOUR_DOMAIN'

# It could be either your user name or api_key.
user_name_or_api_key = 'YOUR_API_KEY'

# If you have given api_key, then it should be x. If you have given user name, it should be password
password_or_x = 'X'

json_payload = { :status => '2',  
                 :priority => 1, 
                 :description=>"test ticket creation with attachments", 
                 :subject=>"new ticket sample", 
                 :cc_emails=>["myemail@testexample.com","test@testexample.com"], 
                 :email => "test@test.com" }.to_json

api_path = "api/v2/tickets"

api_url  = "https://#{fd_domain}.freshdesk.com/#{api_path}"

site = RestClient::Resource.new(api_url, user_name_or_api_key, password_or_x)

begin
  response = site.post(json_payload, :content_type=>'application/json')
  puts "response_code: #{response.code} \n Location Header: #{response.headers[:location]}\n response_body: #{response.body}"
rescue RestClient::Exception => exception
  puts "API Error: Your request is not successful. If you are not able to debug this error properly, mail us at support@freshdesk.com with the follwing X-Request-Id"
  puts "X-Request-Id : #{exception.response.headers[:x_request_id]}"
  puts "Response Code: #{exception.response.code} Response Body: #{exception.response.body} "
end