module Naver
  class Connection
    # Base URI for the NAVER API..
    DEFAULT_API_BASE_URI = "https://openapi.naver.com"

    # Create a Connection object.
    # @param api_base_uri [String] Base URI at which to make API calls.
    def initialize(api_base_uri: DEFAULT_API_BASE_URI)
      @client_id     = Naver.client_id
      @client_secret = Naver.client_secret
      @api_base_uri  = api_base_uri

      headers = { user_agent: "NAVER Ruby SDK Gem #{ Naver::Sdk::VERSION}" }
      @connection = Faraday.new(url: @api_base_uri, headers: headers) do |faraday|
        faraday.request :multipart
        faraday.request :url_encoded
        faraday.response :logger if Naver.debug
        faraday.adapter :net_http
      end
    end

    # Perform a GET request.
    # @param path [String] The path at which to make ther request.
    # @param params [Hash] A hash of request parameters.
    def get(path, params = {})
      request(:get, path, params)
    end

    # Perform a PUT request.
    # @param path [String] The path at which to make ther request.
    # @param params [Hash] A hash of request parameters.
    def put(path, params = {})
      request(:put, path, params)
    end

    # Perform a POST request.
    # @param path [String] The path at which to make ther request.
    # @param params [Hash] A hash of request parameters.
    def post(path, params = {})
      request(:post, path, params)
    end

    # Perform a DELETE request.
    # @param path [String] The path at which to make ther request.
    # @param params [Hash] A hash of request parameters.
    def delete(path, params = {})
      request(:delete, path, params)
    end

    private

    def request(verb, path, params = {})
      raise ArgumentError.new "Invalid http verb #{verb}" if ![:get, :post, :put, :delete].include?(verb)

      response = @connection.run_request(verb, path, params, public_auth_header) do |request|
        request.params.update(params) if verb == :get && params
        yield(request) if block_given?
      end

      if !(200..299).include?(response.status)
        body = JSON.parse(response.body)
        raise Naver::Error.new(body)
      end

      response
    end

    def public_auth_header
      {
        "X-Naver-Client-Id" => @client_id,
        "X-Naver-Client-Secret" => @client_secret
      }
    end
  end
end
