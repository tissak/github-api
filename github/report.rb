module GitHub
  class Report
    # Will pull a list of all the repos being watched by all people a user follows
    def self.most_watched(name=GitHub::USERNAME)
      following = GitHub::User.following_usernames(name)
      watch_lists = following.collect do |username|
        GitHub::User.watching(username)        
      end
      results = {}
      watch_lists.flatten.each do |repo|
        item = repo.name
        results[item] = results[item].nil? ? 1 : (results[item]+1)
      end
      results
    end
  end
end