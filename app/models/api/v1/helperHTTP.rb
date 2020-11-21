module Api
  module V1
    class HelperHTTP

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

      page = 1
      whole_data = []
      url = "https://api.github.com/search/repositories?sort=stars&order=desc&page=#{page}&q=created:>#{date}"
      print url
      response = fetchGithubApi(url)
      data = JSON.parse(response.body)
      whole_data.push(data['items'])

      while page <= 2
        url = "https://api.github.com/search/repositories?sort=stars&order=desc&page=#{page}&q=created:>#{date}"
        print url
        response = fetchGithubApi(url)
        data = JSON.parse(response.body)
        items = data['items']
        whole_data.push(items)
        page +=1
      end

      print "\ndata = " + JSON.pretty_generate(whole_data)

      response.body = whole_data
      response

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