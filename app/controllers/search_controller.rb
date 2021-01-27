class SearchController < ApplicationController
  def find_videos
    @video_id =  ""
    @sort = "評価順"

    if params[:video_id] != "" && params[:video_id] != nil

      require 'google/apis/youtube_v3'
      youtube = Google::Apis::YoutubeV3::YouTubeService.new
      youtube.key = ENV['API_KEY']

      next_page_token = nil
      @video_id = params[:video_id]
      @sort = params[:sort]

      if @sort == "評価順"
        opt = {
          max_results: 100,
          order: "relevance",
          page_token: next_page_token,
          text_format: 'plainText',
          video_id: @video_id
        }
      else
        opt = {
          max_results: 100,
          page_token: next_page_token,
          text_format: 'plainText',
          video_id: @video_id
        }
      end

      begin
        @comments = youtube.list_comment_threads(:snippet, opt).items
      rescue
        @comments = nil
      end
    end
  end
end
