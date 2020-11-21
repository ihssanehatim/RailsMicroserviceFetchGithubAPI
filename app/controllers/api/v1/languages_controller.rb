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
      #          [503] => Service Unavailable #done
      #          [204] => No Content
      #          [400] => Bad Request #done
      def index

        response = find_trending(30.days.ago.to_date)

        returned_code = validate_api_response(response)

        back_to_client(returned_code)

        #render json: {status: 404 , message: "NOT FOUND" , data: "NO DATA"}, status: :not_found

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

        # expect one or more status codes, or raise an error in case no connection created or others
        begin
          connection = Excon.new(url)
          connection.request(:method => :get)
        rescue StandardError => e
          nil
        end
        #return nil if response.status != 200 ### if it fails we must return NULL
        #response ### else return a JSON object of the result [body]

        #print response
      end

    #### Within this method we must provide the exact URL that must be fetched
    #    In order to get the needed data ;
    #    In this case : We need the exact 100 first repos
    #
      def find_trending(date)

        url = "https://api.github.com/search/repositories?sort=stars&orde=desc&page=1&per-page=100&q=created:>#{date}"
        print url
        fetchGithubApi(url)

      end

    #
    # This method validates the given response from the api
    # to do that , it takes the response and compare it with
    # what I am expecting as a success or not
    # then turn back with a unified error => to define new standard
    #
      def validate_api_response(response)

        if response.nil?

          :service_unavailable

        elsif response.status == 204 || response.status == 200

          response.status

        else

          :internal_server_error

        end

      end

    # This method must provide the required data (following given structure)
    # to do that I MUST loop over the body of the result
    # then rendering the list of languages with their attributes :
    # Serving it in a JSON format + setting up the status to :ok [SUCCESS]
    # and if no data available => setting up the status to [204] => No Content

      def back_to_client(returned_code)

        if returned_code == :service_unavailable || returned_code == :internal_server_error

          render json: { message: returned_code , status: Rack::Utils.status_code(returned_code) } , status: returned_code

        else
          # here I must provide the required data (following given structure)
          # to do that I MUST loop over the body of the result
          # then rendering the list of languages with their attributes :
          # Serving it in a JSON format + setting up the status to :ok [SUCCESS]
          # and if no data available => setting up the status to [204] => No Content
          render json: returned_code , status: returned_code

        end

      end

    end
  end
end


###############
#  if response.nil?
#
#           render json: { message: "service unavailable" , status: "503" }, status: :service_unavailable
#
#         elsif response.status == 204 || response.status == 200
#
#           render  json: response.body , status: response.status
#
#         else
#
#           render  json: { message: "internal server error" , status: "500" } , status: :internal_server_error
#
#         end
# ############################