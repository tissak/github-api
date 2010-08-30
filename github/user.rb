module GitHub
  class User
    def initialize(hsh)
      @attributes = hsh
    end

    def self.fetch(name)
      results = API.get("user/show/#{name}")
      GitHub::User.new(results["user"])
    end
    
    def self.search(name)
      results = API.get("user/search/#{name}")
      results["users"].collect {|r| GitHub::User.new(r)}
    end
    
    def self.follower_usernames(username)
      results = API.get("user/show/#{username}/followers")
      results["users"]
    end

    def self.following_usernames(username)
      results = API.get("user/show/#{username}/following")
      results["users"]
    end    
    
    def follower_usernames
      results = API.get("user/show/#{self.username}/followers")
      results["users"]
    end
    
    def following_usernames
      results = API.get("user/show/#{self.username}/following")
      results["users"]
    end
    
    def watching
      results = API.get("repos/watched/#{self.username}")
      results["repositories"].collect {|r| GitHub::Repository.new(r)}
    end
    
    def self.watching(username)
      results = API.get("repos/watched/#{username}")
      results["repositories"].collect {|r| GitHub::Repository.new(r)}
    end
    
    ["name", "location", "followers", "language", "fullname", "repos", "id", "type", "pushed", "score", "created"].each do |arg|
      send :define_method, arg.to_sym do 
        @attributes[arg]||@attributes[arg.to_sym]
      end
    end
    
    def username
      @attributes["username"] || @attributes["login"]
    end
    
  end
end