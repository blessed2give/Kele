class Kele::Roadmap
  def get_roadmap( roadmap_id )
    options = { headers: { "authorization" => @auth_token } }
    response = self.class.get( BASE_URI + '/roadmaps/' + roadmap_id.to_s, options )
  end

  def get_checkpoint( checkpoint_id )
    options = { headers: { "authorization" => @auth_token } }
    response = self.class.get( BASE_URI + '/checkpoints/' + checkpoint_id.to_s, options )
  end
end
