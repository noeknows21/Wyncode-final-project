class UnzipTokWorker
  include Sidekiq::Worker
  def perform(file_url)
    # do something
    # Setup AWS credentials
    p "TEST 1 TEST 1 TEST 1"
    AWS.config(access_key_id: ENV['S3_KEY'], secret_access_key: ENV['S3_SECRET'])

    # Upload a file.
    s3 = AWS::S3.new
    p "TEST 2 TEST 2 TEST 2"
    # unzip file
    @response = RestClient::Request.execute({:url => file_url, :method => :get, :content_type => 'application/zip'})
    p "TEST 3 TEST 3"
    Zip::File.open_buffer(@response) do |zip_file|
      zip_file.each do |entry|
        p "TEST 4 TEST 4"
        s3.buckets[ENV['S3_BUCKET']].objects["transcoder/input/#{entry.name}"].write(entry.get_input_stream.read)
        p "TEST 5 TEST 5"
      end
    end
  end
end
