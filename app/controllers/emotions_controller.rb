class EmotionsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def graph

    headers = {
      "app_id" => ENV["KAIROS_API_ID"],
      "app_key" => ENV["KAIROS_API_KEY"]
    }

    # @video_url = "https://s3.amazonaws.com/pitchusers/transcoder/output/e9885853-8359-42dd-9f4f-d30cf30187c4-1457396327032.mp4"
    @video_url = "https://s3.amazonaws.com/pitchusers/transcoder/output/" +params[:url] + ".mp4"
    @response = HTTParty.post("https://api.kairos.com/media?source=#{@video_url}&timeout=26", { headers: headers })
    
    
    @smile_pre_array = []
    @frown_pre_array = []
    @smile_array = []
    @frown_array = []
    
    @response['frames'].each do |f|
      f['person']['emotions'].each do |k,v|
        case k
        when "smile"
          @smile_pre_array << v
        when "negative"
          @frown_pre_array << v
        end
      end
    end
    
    
    @smile_pre_array.each_slice(30) {|ele|
      @smile_array << (ele.inject(:+) / ele.size.to_f).round(3)
    }
    
    @frown_pre_array.each_slice(30) {|ele|
      @frown_array << (ele.inject(:+) / ele.size.to_f).round(3)
    }

  end

  def display
    @current_user_videos = []
    @pre_current_user_videos = []
    
    current_user.videos.each do |v|
      unless v.url.include?('http')
        @pre_current_user_videos << v.url
      end
    end
    
    @pre_current_user_videos.each_with_index do |v,index|
      if index % 2 == 1
        @current_user_videos << v
      end
    end
  end

  def mp4_created
    
    @receive_mp4 = params[:key]
    p @receive_mp4
    
    # @formatted_mp4 = "https://s3.amazonaws.com/pitchusers/" + @receive_mp4
    User.all.order(updated_at: :desc).first.videos.create(url: @receive_mp4)
  end

  def index
    file_path = params[:url]
    if file_path != nil
      file_url = file_path.split('?').first
      # file_url = "https://s3.amazonaws.com/pitchusers/45508312/0803f85d-c175-4db0-9c35-2c92fc1c8319/archive.zip"
      UnzipTokWorker.perform_async(file_url)
    else
      p "STATUS UPDATE #{params[:emotion]}"
    end
  end
end
