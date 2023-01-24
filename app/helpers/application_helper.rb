module ApplicationHelper

  def session_is_valid?(token)
    puts "Token supplied #{token}"
    session = Session.find_by_token(token)
    if session.nil?
      puts "Session not found"
      return false
    end
    puts "Limit is #{session.limit}"
    puts "Now is #{DateTime.now}"
    puts "Comp is #{session.limit > DateTime.now}"
    return session.limit > DateTime.now
  end

  def extend_session (token)
    session = Session.find_by_token(token)
    unless session.nil?
      session.limit = DateTime.now + 5.minutes
      session.save!
    end
  end

end
