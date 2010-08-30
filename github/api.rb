module GitHub
  BASE_HOST = "github.com"
  BASE_URL = "/api/v2/yaml"
  
  USERNAME = "tissak"
  TOKEN = "ba1c1570092a0eb26187753a0fb7f17a"
  
  class API
    def self.get_url(parts)
      url = "#{BASE_URL}/#{parts}"
      puts url
      url
    end
    
    def self.get(parts)
      username, token = self.config
      url = self.get_url(parts) 
      content = ""     
      Net::HTTP.start(GitHub::BASE_HOST) do |http|
        req = Net::HTTP::Get.new(url)
        req.basic_auth "#{username}/token", token
        response = http.request(req)
        content = response.body
      end      
      YAML::load(content)
    end
    
    def self.config
      conf = YAML::load_file(File.join(File.dirname(__FILE__),"..","config.yml"))
      return conf[:username], conf[:token]
    end
  end
end


    