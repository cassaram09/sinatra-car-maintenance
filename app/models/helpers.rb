class Helpers < ActiveRecord::Base

  def self.is_logged_in?(session)
    !!session[:id]
  end

  def self.current_user(session)
    User.find_by_id(session[:id])
  end
  
end