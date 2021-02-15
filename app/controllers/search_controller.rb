class SearchController < ApplicationController
  def find_comments
    @url =  ""
    @sort = "relevance"

    if params[:url].present?

      @url = params[:url]
      @sort = params[:sort]

      if params[:num].nil?
        @num = 0
        @video_id = YoutubeApi.format_url(@url)
        if @video_id.nil?
          @comments = "このURLの動画は存在しません"
          return
        end
      else
        @num = params[:num].to_i + 1
        @video_id = params[:video_id]
      end

      begin
        @comments = []
        @page_token = params[:page_token]
        20.times do
          res_body = YoutubeApi.comments(@video_id, 50, @sort, @page_token)
          res_body["items"].each do |item|
            if item["snippet"]["topLevelComment"]["snippet"]["textDisplay"] =~ /(?:\p{Hiragana}|\p{Katakana}|[一-龠々])/
              hash = {}
              hash[:id] = item["id"]
              hash[:author_display_name] = item["snippet"]["topLevelComment"]["snippet"]["authorDisplayName"]
              hash[:author_profile_image_url] = item["snippet"]["topLevelComment"]["snippet"]["authorProfileImageUrl"]
              hash[:like_count] = item["snippet"]["topLevelComment"]["snippet"]["likeCount"]
              hash[:published_at] = item["snippet"]["topLevelComment"]["snippet"]["publishedAt"]
              hash[:text_display] = item["snippet"]["topLevelComment"]["snippet"]["textDisplay"]
              hash[:total_reply_count] = item["snippet"]["totalReplyCount"]
              @comments << hash
            end
          end
          @page_token = res_body["nextPageToken"]
          break if @comments.size >= 50 || @page_token.nil?
        end
      rescue
        @comments = "このIDの動画は存在しません。"
        return
      end
    else
      @comments = "URLを入力してください。"
      @num = 0
      return
    end
  end
  
  def find_reply
    @comment_id = params[:comment_id]
    @replies = YoutubeApi.all_replies(@comment_id, 100, 500)
  end
end
