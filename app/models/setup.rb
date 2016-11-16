class Setup < ActiveRecord::Base
	ActiveRecord::Base.establish_connection($current_session_db)
	include PublicActivity::Common
	def self.weather_details
		begin
        @client = YahooWeather::Client.new
        @response = @client.fetch(1582504)
        @doc = @response.doc
        @forecast = @doc["item"]["forecast"]
   rescue SocketError => e
    flash[:danger] = "received Exception #{e.message}"
    end
	end
end
