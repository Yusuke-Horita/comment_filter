class SearchController < ApplicationController
  def find_comments
    @url =  ""
    @sort = "評価順"

    if params[:url] != "" && params[:url] != nil

      require 'google/apis/youtube_v3'
      youtube = Google::Apis::YoutubeV3::YouTubeService.new
      youtube.key = ENV['API_KEY']

      @url = params[:url]
      @sort = params[:sort]

      if @url.include?("&feature=youtu.be")
        @url = @url.gsub("&feature=youtu.be", "")
      end

      if params[:num] == nil
        @num = 0

        if @url.include?("https://www.youtube.com/watch?v=")
          @video_id = @url.gsub("https://www.youtube.com/watch?v=", "")
        elsif @url.include?("https://m.youtube.com/watch?v=")
          @video_id = @url.gsub("https://m.youtube.com/watch?v=", "")
        elsif @url.include?("https://youtu.be/")
          @video_id = @url.gsub("https://youtu.be/", "")
        else
          @comments = "このURLの動画は存在しません。"
          @num = 0
          return
        end
      else
        @num = params[:num].to_i + 1
        @video_id = params[:video_id]
        next_page_token = params[:next_page_token]
      end

      if @sort == "評価順"
        opt = {
          max_results: 50,
          order: "relevance",
          page_token: next_page_token,
          text_format: 'plainText',
          video_id: @video_id
        }
      else
        opt = {
          max_results: 50,
          page_token: next_page_token,
          text_format: 'plainText',
          video_id: @video_id
        }
      end

      begin
        comments_original = youtube.list_comment_threads(:snippet, opt)

        @comments = []

        comments_original.items.each do |comment|
          if comment.snippet.top_level_comment.snippet.text_display =~ /(?:\p{Hiragana}|\p{Katakana}|[一-龠々])/
            hash = {}
            hash[:id] = comment.id
            hash[:author_display_name] = comment.snippet.top_level_comment.snippet.author_display_name
            hash[:author_profile_image_url] = comment.snippet.top_level_comment.snippet.author_profile_image_url
            hash[:like_count] = comment.snippet.top_level_comment.snippet.like_count
            hash[:published_at] = comment.snippet.top_level_comment.snippet.published_at
            hash[:text_display] = comment.snippet.top_level_comment.snippet.text_display
            hash[:total_reply_count] = comment.snippet.total_reply_count
            @comments << hash
          end
        end

        @next_page_token = comments_original.next_page_token

        if @next_page_token && @comments.size < 50
          @if = "ififif"
          9.times do
            opt[:page_token] = @next_page_token
            comments_original = youtube.list_comment_threads(:snippet, opt)

            comments_original.items.each do |comment|
              if comment.snippet.top_level_comment.snippet.text_display =~ /(?:\p{Hiragana}|\p{Katakana}|[一-龠々])/
                hash = {}
                hash[:id] = comment.id
                hash[:author_display_name] = comment.snippet.top_level_comment.snippet.author_display_name
                hash[:author_profile_image_url] = comment.snippet.top_level_comment.snippet.author_profile_image_url
                hash[:like_count] = comment.snippet.top_level_comment.snippet.like_count
                hash[:published_at] = comment.snippet.top_level_comment.snippet.published_at
                hash[:text_display] = comment.snippet.top_level_comment.snippet.text_display
                hash[:total_reply_count] = comment.snippet.total_reply_count
                @comments << hash
              end
            end
            if @comments.size >= 50
              @next_page_token = comments_original.next_page_token
              return
            end
            @next_page_token = comments_original.next_page_token
          end
        end
      rescue
        @comments = "このIDの動画は存在しません。"
        return
      end
    else
      @comments = "IDを入力してください。"
      @num = 0
      return
    end
  end
  
  def find_reply

    require 'google/apis/youtube_v3'
    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.key = ENV['API_KEY']

    @comment_id = params[:comment_id]

    opt = {
      max_results: 100,
      text_format: 'plainText',
      parent_id: @comment_id
    }

    @replies = youtube.list_comments(:snippet, opt).items
  end
end
