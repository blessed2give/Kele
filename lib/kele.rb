require 'httparty'
require 'json'
#require 'kele/roadmap'

class Kele
#  include 'kele'
  include HTTParty
  BASE_URI = 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    @email = email
    @password = password
  end

  def get_me
    options = { body: { email: @email, password: @password } }
    response = self.class.post( BASE_URI + '/sessions', options )
    @auth_token = response['auth_token']
  end

  def get_mee
    options = { headers: { "authorization" => @auth_token } }
    response_current_user = self.class.get( BASE_URI + '/users/me', options )
  end

  def get_mentor_availability( mentor_id )
    options = {
      headers: { "authorization" => @auth_token },
      body: { id: mentor_id }
   }
    response = self.class.get( BASE_URI + '/mentors/' + mentor_id + '/student_availability', options )
  end

  def get_roadmap( roadmap_id )
    options = { headers: { "authorization" => @auth_token } }
    response = self.class.get( BASE_URI + '/roadmaps/' + roadmap_id.to_s, options )
  end

  def get_checkpoint( checkpoint_id )
    options = { headers: { "authorization" => @auth_token } }
    response = self.class.get( BASE_URI + '/checkpoints/' + checkpoint_id.to_s, options )
  end

  def get_messages(page)
    options = {
      headers: { "authorization" => @auth_token },
      body: { page: page }
    }
    response = self.class.get( BASE_URI + '/message_threads', options)
  end

  def create_message( mentor_id, message )
    options = {
      headers: { "authorization" => @auth_token },
      body: { sender: @email, recipient_id: mentor_id.to_s, stripped_text: message }
    }
    response = self.class.post( BASE_URI + '/messages', options )
  end

  def create_submission( checkpoint_id, assignment_branch, assignment_commit_link, comment, enrollment_id )
    options = {
      headers: { "authorization" => @auth_token },
      body: { checkpoint_id: checkpoint_id.to_s, assignment_branch: assignment_branch, assignment_commit_link: assignment_commit_link, comment: comment, enrollment_id: enrollment_id.to_s }
    }
    response = self.class.post( BASE_URI + '/checkpoint_submissions', options )
  end
end
