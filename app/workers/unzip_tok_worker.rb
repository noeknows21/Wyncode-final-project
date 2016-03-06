class UnzipTokWorker
  include Sidekiq::Worker
  def perform_async(file_url)
    # do something
    # Setup AWS credentials
    AWS.config(access_key_id: ENV['S3_KEY'], secret_access_key: ENV['S3_SECRET'])

    # Upload a file.
    s3 = AWS::S3.new

    # unzip file
    @response = RestClient::Request.execute({:url => file_url, :method => :get, :content_type => 'application/zip'})
    Zip::File.open_buffer(@response) do |zip_file|
      zip_file.each do |entry|

        s3.buckets[ENV['S3_BUCKET']].objects["transcoder/input/#{entry.name}"].write(entry.get_input_stream.read)

      end
    end
  end
end
