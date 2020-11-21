module Api
  module V1
    class Language
      
      # constructor of this class
      def initialize
        @list_of_repos = Array.new # => []
        @number_of_repos = 0
      end

      # this method increments the number of repos using this language
      def increment_number
        @number_of_repos += 1
      end

      # this method allows to store the given url of the repo
      def add_to_list(url)
        @list_of_repos.push(url) # insert at the end
        # (we can use unshift if we want to simulate a LIFO structure)
      end

      # returns an array of stored repos
      def get_list
        @list_of_repos
      end

      # returns the number of repos using this language
      def get_number
        @number_of_repos
      end
    end
  end
end
