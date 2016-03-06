class EmotionsController < ApplicationController

  def display
    # open tok credentials
    headers = {
      "app_id" => '4985f625',
      "app_key" => '24ad28c4dd3c94df26b2ac78d96a5ccf'
    }

    # make a post request to kairos api
    @response = HTTParty.post('https://api.kairos.com/media?source=https://s3.amazonaws.com/pitchusers/45508312/2bac4a6c-9b78-4bdc-badf-b2a6a521df67/archive.mp4', { headers: headers })
  end

  def index
    # @file_path = params[:url]
    # @file_url = @file_path.split('?').first
    @file_url = "https://s3.amazonaws.com/tokbox.com.archive2/45508312%2Ff75dcfdf-26c3-4ce8-848d-78f7186aa6a8%2Farchive.zip"

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
