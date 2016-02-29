class EmotionsController < ApplicationController
  
  def display
    
      headers = {  
       "app_id" => '4985f625',  
       "app_key" => '24ad28c4dd3c94df26b2ac78d96a5ccf'  
      }  

     @response = HTTParty.post('https://api.kairos.com/media?source=https://s3.amazonaws.com/pitchusers/45508312/fa4aa2be-d1c1-436e-b445-fd095c40d744/archive.mp4&timeout=30', { headers: headers })  
  end
  
end
