module Api

  module V1

    class LanguagesController < ApplicationController

      # in this method => list all languages we have on trending repos from Github API v3:
      # Following REST standards
      # structure will be :
      # {
      #   "language" : "Ruby",
      #   "number_of_repos" : 40,
      #   "list_of_repos" : {
      #                        "URL1",
      #                        "URL2",
      #                         ...
      #                       }
      #  }
      # end of structure ;
      # Status : [200] => SUCCESS
      #          [503] => Service Unavailable
      #          [204] => No Content
      #          [400] => Bad Request
      def index
        find_trending(30.days.ago.to_date)
      end

    ########## PRIVATE SECTION ################

    private

    #### this method checks the status of the returned result
    #
    #    after fetching given URL
    #     returns the JSON , else returns NULL
    #     in this method I will call Excon to fetch the github API
    #
      def fetchGithubApi(url)

        response = Excon.get(url)

        return nil if response.status != 200 ### if it fails we must return NULL

        JSON.parse(response.body) ### else return a JSON object of the result [body]
        print response
      end

    #### Within this method we must provide the exact URL that must be fetched
    #    In order to get the needed data ;
    #    In this case : We need the exact 100 first repos
    #
    # @param [Object] date
      def find_trending(date)

        url = "https://api.github.com/search/repositories?sort=stars&order=desc&page=1&per-page=100&q=created:>#{date}"
        print url
        fetchGithubApi(url)

      end

    end
  end
end