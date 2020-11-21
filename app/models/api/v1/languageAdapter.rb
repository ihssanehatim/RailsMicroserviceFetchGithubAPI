module Api
  module V1

    class LanguageAdapter
      #
      # this method filter the data to a hash that contains <key = language , value = Language Model >
      #
      # @return [Hash]
      def self.format(data)
        hash = Hash.new
        # without forgetting that returned data is paginated :
        page = 0
        while page < 3
          array_of_items = data[page]
          puts "number of items = "+ array_of_items.length.to_s

          row = 0
          number_rows = array_of_items.length
          ####### create the structure we need :
          while row < number_rows

          language = array_of_items[row]['language']
          url = array_of_items[row]['html_url']

          wanted_language = if hash.key?(language)
                              hash[language]
                            else
                              hash[language] = Language.new
                            end

          wanted_language.increment_number
          wanted_language.add_to_list(url)
          hash[language] = wanted_language #store the exact new values

          a = hash[language]
          unless language.nil?
            puts "\nlanguage = "+ language +",row = "+row.to_s+",number = " + a.get_number.to_s
          end

          row += 1

          end

          page += 1

        end
        # return the result ::
        hash
      end

      # this method MUST return the formatted structure
      # {
      #   "language" : "Ruby",
      #   "number_of_repos" : 40,
      #   "list_of_repos" : {
      #                        "URL1",
      #                        "URL2",
      #                         ...
      #                       }
      #  }
      #
      def self.adapt(hash)
        data = []

        hash.each_key do |language|
          target = hash[language]
          number_of_repos = target.get_number
          list_of_repos = target.get_list
          data.push({language: language , number_of_repos: number_of_repos , list_of_repos: list_of_repos})
        end
        # return all the structured data
        data

      end

      def self.adapter(data)
        hash = format(data)
        adapt(hash)
      end

    end
  end
end
