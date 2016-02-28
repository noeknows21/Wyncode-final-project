class EmotionsController < ApplicationController
  
  def display
    
      headers = {  
       "app_id" => '4985f625',  
       "app_key" => '24ad28c4dd3c94df26b2ac78d96a5ccf'  
      }  

     @response = HTTParty.post('https://api.kairos.com/media?source=https://s3.amazonaws.com/pitchusers/45508312/9d34c31e-bfbd-4d43-8e5d-8c29b7175d13/archive.mp4', { headers: headers })  
  end
  
end
