class EmotionsController < ApplicationController

  def graph

    headers = {
      "app_id" => '4985f625',
      "app_key" => '24ad28c4dd3c94df26b2ac78d96a5ccf'
    }
    
    # @video_url= "https://s3.amazonaws.com/pitchusers/transcoder/output/f29b202b-1de6-4d12-9cf5-b4b37f4e8d7d-1457292784695.mp4"
    # @formatted_url = "https://api.kairos.com/media?source=#{@video_url}&timeout=59"
    # @response = HTTParty.post("#{@formatted_url}", { headers: headers })
    @shit = "https://s3.amazonaws.com/pitchusers/transcoder/output/f29b202b-1de6-4d12-9cf5-b4b37f4e8d7d-1457292784695.mp4"
    @response = HTTParty.post("https://api.kairos.com/media?source=#{@shit}&timeout=30", { headers: headers })
    
    # @response = HTTParty.post("https://api.kairos.com/media?source=https://s3.amazonaws.com/pitchusers/transcoder/output/f29b202b-1de6-4d12-9cf5-b4b37f4e8d7d-1457292784695.mp4&timeout=30", { headers: headers })

    # @body = JSON.parse(@response.body)
    
    
    
    
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
    
    
    
    
    # @smile_pre_array.delete(0)
    # @frown_pre_array.delete(0)
    
    
    
    
    
    
    @smile_pre_array.each_slice(30) {|ele|
      @smile_array << (ele.inject(:+) / ele.size.to_f).round(3)
    }
    
    @frown_pre_array.each_slice(30) {|ele|
      @frown_array << (ele.inject(:+) / ele.size.to_f).round(3)
    }

  end

  def display
  end

  def index
    @file_path = params[:url]
    @file_url = @file_path.split('?').first
    # @file_url = "https://s3.amazonaws.com/tokbox.com.archive2/45508312%2Ff75dcfdf-26c3-4ce8-848d-78f7186aa6a8%2Farchive.zip"

    # unzip file
    @response = RestClient::Request.execute({:url => @file_url, :method => :get, :content_type => 'application/zip'})
    Zip::File.open_buffer(@response) do |zip_file|
      zip_file.each do |entry|

        # Setup AWS credentials
        AWS.config(access_key_id: ENV['S3_KEY'], secret_access_key: ENV['S3_SECRET'])

        # Upload a file.
        s3 = AWS::S3.new
        s3.buckets[ENV['S3_BUCKET']].objects["#{entry.name}"].write(entry.get_input_stream.read)

      end
    end
  end
end
