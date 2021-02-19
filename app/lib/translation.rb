class Translation
	BASE_URL = "https://translation.googleapis.com/language/translate/v2/"
	API_KEY = ENV["API_KEY"]

	def self.detect(text)
		connection = Faraday.new( BASE_URL ) do |builder|
			builder.request :url_encoded
      builder.adapter Faraday.default_adapter
		end
		responce = connection.post("detect") do |request|
			request.params[:key] = API_KEY
			request.params[:q] = text
		end

		res_body = JSON.parse(responce.body)
		language = res_body["data"]["detections"][0][0]["language"]
	end
end