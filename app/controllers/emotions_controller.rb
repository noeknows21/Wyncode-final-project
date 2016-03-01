class EmotionsController < ApplicationController

  def display
    headers = {
      "app_id" => '4985f625',
      "app_key" => '24ad28c4dd3c94df26b2ac78d96a5ccf'
    }

    @response = HTTParty.post('https://api.kairos.com/media?source=https://s3.amazonaws.com/pitchusers/45508312/2bac4a6c-9b78-4bdc-badf-b2a6a521df67/archive.mp4', { headers: headers })
  end
end
