module Sinatra
  module Authorization
 
  def getSavedInfo        
    return {:name => "admin", :password => "admin"}
  end

  def protected!
    unless authorized?
      #response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
      #throw(:halt, [401, "Not authorized\n"])
      redirect "/login"
    end
  end

  def authorized?    
      userInfo = getSavedInfo

      hashedPassword = Digest::SHA1.hexdigest userInfo[:password]
      
      userNameMatches = session[:username] == userInfo[:name]
      passwordMatches = session[:password] == hashedPassword
      return (userNameMatches && passwordMatches)
  end

  def authenticate(username, password)
    userInfo = getSavedInfo

    hashedPassword = Digest::SHA1.hexdigest userInfo[:password]
    hashedInputPassword = Digest::SHA1.hexdigest password

    isAuth = username == userInfo[:name] and hashedPassword == hashedInputPassword

    return isAuth
  end


  def login(username, password)
    if authenticate username, password 
      session[:username] = username
      session[:password] = Digest::SHA1.hexdigest password
      return true
    end    
    return false
  end

  def logout
    session.clear
  end

  end
end