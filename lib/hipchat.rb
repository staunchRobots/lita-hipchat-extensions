# Class responsible for handling calls to the Hipchat V2 API
class Hipchat
  include HTTParty
  # Base url is Hipchat V2 API
  base_uri 'https://api.hipchat.com/v2/'
  # Use a logger for the requests 
  logger ::Logger.new("./hipchat.log"), :debug, :apache
  # TODO: May want to turn this off before releasing
  # debug_output $stderr
  # @return [String] the authentication token for making calls
  attr_accessor :token

  def initialize(token)
    @token   = token
    @options = { :query => { :auth_token => @token } }
  end

  # Fetches all the users registered in the Hipchat domain
  # @return [Array, nil] the list of users if success, nil otherwise
  def users
    self.class.get("/user", @options).parsed_response["items"]
  end

  # Fetches a single user's details
  # @return [Hash, nil] the user's metadata if success, nil otherwise
  def user(id)
    self.class.get("/user/#{id}", @options).parsed_response
  end
end