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

        back_to_client

      end

      private


      # This method must provide the required data (following given structure)
      # to do that I MUST loop over the body of the result
      # then rendering the list of languages with their attributes :
      # Serving it in a JSON format + setting up the status to :ok [SUCCESS]
      # and if no data available => setting up the status to [204] => No Content

      def back_to_client

        response = HelperHTTP.find_trending(30.days.ago.to_date)

        returned_code = HelperHTTP.validate_api_response(response)

        if returned_code == :service_unavailable || returned_code == :internal_server_error

          render json: { message: returned_code , status: Rack::Utils.status_code(returned_code) } , status: returned_code

        else
          # here I must provide the required data (following given structure)
          # to do that I MUST loop over the body of the result
          # then rendering the list of languages with their attributes :
          # Serving it in a JSON format + setting up the status to :ok [SUCCESS]
          # and if no data available => setting up the status to [204] => No Content
          data = response.body

          adapted_data = LanguageAdapter.adapter(data)

          render json: adapted_data , status: returned_code

        end

      end


    end
  end
end