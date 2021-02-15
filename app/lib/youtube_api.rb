class YoutubeApi
  BASE_URL = "https://www.googleapis.com/youtube/v3/"
  API_KEY = ENV['API_KEY']

  def self.comments(video_id, max_results = 100, sort = "relevance", page_token = nil)
    connection = Faraday.new( BASE_URL ) do |builder|
      builder.request :url_encoded
      builder.adapter Faraday.default_adapter
    end
    responce = connection.get("commentThreads") do |request|
      request.params[:key] = API_KEY
      request.params[:part] = "snippet"
      request.params[:videoId] = video_id
			request.params[:maxResults] = max_results
			request.params[:order] = sort
      request.params[:textFormat] = "plainText"
      request.params[:pageToken] = page_token if page_token.present?
    end
    res_body = JSON.parse(responce.body)
  end

  def self.all_comments(video_id, max_results = 100, limit = 100)
    items = []
    page_token = nil
    loop do
      res_body = self.comments(video_id, max_results, page_token)
      items.concat(res_body["items"])
      page_token = res_body["nextPageToken"]
      print "."
      break if items.size >= limit || page_token.nil?
    end
    items
  end

  def self.replies(comment_id, max_results = 100, page_token = nil)
    connection = Faraday.new( BASE_URL ) do |builder|
      builder.request :url_encoded
      builder.adapter Faraday.default_adapter
    end
    responce = connection.get("comments") do |request|
      request.params[:key] = API_KEY
      request.params[:part] = "snippet"
      request.params[:parentId] = comment_id
      request.params[:maxResults] = max_results
      request.params[:textFormat] = "plainText"
      request.params[:pageToken] = page_token if page_token.present?
    end
    res_body = JSON.parse(responce.body)
  end

  def self.all_replies(comment_id, max_results = 100, limit = 100)
    items = []
    page_token = nil
    loop do
      res_body = self.replies(comment_id, max_results, page_token)
      items.concat(res_body["items"])
      page_token = res_body["nextPageToken"]
      break if items.size >= limit || page_token.nil?
    end
    items
  end

	def self.format_url(url)
		if url.include?("&feature=youtu.be")
			url = url.gsub("&feature=youtu.be", "")
		end

		if url.include?("https://www.youtube.com/watch?v=")
			video_id = url.gsub("https://www.youtube.com/watch?v=", "")
		elsif url.include?("https://m.youtube.com/watch?v=")
			video_id = url.gsub("https://m.youtube.com/watch?v=", "")
		elsif url.include?("https://youtu.be/")
			video_id = url.gsub("https://youtu.be/", "")
		end
		video_id
  end
end