class EmotionsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def graph

    headers = {
      "app_id" => '4985f625',
      "app_key" => '24ad28c4dd3c94df26b2ac78d96a5ccf'
    }

    @response = HTTParty.post('https://api.kairos.com/media?source=https://s3.amazonaws.com/pitchusers/transcoder/output/6584065f-4bbd-468e-a52b-2ac94232d1f3-1457221322743.mp4&timeout=30', { headers: headers })

    body = JSON.parse(@response.body)
    @smile_pre_array = []
    @frown_pre_array = []
    @smile_array = []
    @frown_array = []


    body['frames'].each do |f|
      f['person']['emotions'].each do |k,v|
        case k
        when "smile"
          @smile_pre_array << v
        when "negative"
          @frown_pre_array << v
        end
      end
    end

    @smile_pre_array.delete(0)
    @frown_pre_array.delete(0)

    @smile_pre_array.each_slice(4) {|ele|
      @smile_array << (ele.inject(:+) / ele.size.to_f)
    }

    @frown_pre_array.each_slice(4) {|ele|
      @frown_array << (ele.inject(:+) / ele.size.to_f)
    }

  end

  def display
  end

  def mp4_created

  end

  def index
    p params
    file_path = params[:url]
    if file_path != nil
      file_url = file_path.split('?').first
      # file_url = "https://s3.amazonaws.com/pitchusers/45508312/0803f85d-c175-4db0-9c35-2c92fc1c8319/archive.zip"
      UnzipTokWorker.perform_async(file_url)
    else
      p "STATUS UPDATE #{params[:status]}"
    end
  end
end
