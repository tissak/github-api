module GitHub
  class Repository
    def initialize(hsh)
      @attributes = hsh
    end
    
    def self.search(term)
      results = API.get("repos/search/#{term}")
      results["repositories"].collect {|r| GitHub::Repository.new(r) }
    end
    
    ["name", "size", "followers", "fork", "language", "username", "id", "type", "pushed", "description", "forks", "score", "created"].each do |arg|
      send :define_method, arg.to_sym do 
        @attributes[arg]||@attributes[arg.to_sym]
      end
    end
  end
end