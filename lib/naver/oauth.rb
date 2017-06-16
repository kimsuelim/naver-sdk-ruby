module Naver
  class Oauth
    # Base URI for NAVER OAuth.
    # DEFAULT_OAUTH_BASE_URI = "https://nid.naver.com/oauth2.0"
    DEFAULT_OAUTH_BASE_URI = "https://nid.naver.com"

    # Create a Oauth object.
    # @param oauth_base_uri [String] Base URI at which to make API calls.
    def initialize(oauth_base_uri: DEFAULT_OAUTH_BASE_URI, redirect_uri: Naver.redirect_uri)
      @client_id     = Naver.client_id
      @client_secret = Naver.client_secret
      @oauth_base_uri = oauth_base_uri
      @redirect_uri = redirect_uri

      headers = { user_agent: "NAVER Ruby SDK Gem #{ Naver::Sdk::VERSION}" }
      @oauth = OAuth2::Client.new(@client_id, @client_secret, site: @oauth_base_uri, authorize_url: "/oauth2.0/authorize", token_url: "/oauth2.0/token", headers: headers) do |http|
        http.request :multipart
        http.request :url_encoded
        http.response :logger if Naver.debug
        http.adapter :net_http
      end
    end

    # Get OAuth URL for user authentication and authorization.
    # @param requested_scopes [Array] An array of permission scopes being requested.
    # @return [String] The authorization URL.
    def authorization_url(requested_scopes: ["public"])
      @oauth.auth_code.authorize_url(
        redirect_uri: @redirect_uri,
        scope: requested_scopes.join("")
      )
    end

    # Generate an access token given an auth code received from NAVER.
    # This is used internally to authenticate and authorize future user actions.
    # @param auth_code [String] The OAuth authentication code from NAVER.
    def authorize!(auth_code)
      @oauth_token = @oauth.auth_code.get_token(auth_code, redirect_uri: @redirect_uri)
      # TODO check if it succeeded
    end

    # Extract hash with OAuth token attributes. Extracted token attributes can
    # be used with create_and_assign_token to prevent the need for
    # reauthorization.
    # @return [Hash, nil] @oauth_token converted to a hash.
    def extract_token
      @oauth_token.to_hash if @oauth_token
    end

    # Create and assign new access token from extracted token. To be used with
    # extract_token to reauthorize app without api call.
    # @param token_extract [Hash] OAuth token hash from #extract_token.
    # @return [OAuth2::AccessToken, nil] New access token object.
    def create_and_assign_token(token_extract)
      unless token_extract.nil?
        @oauth_token = OAuth2::AccessToken.from_hash(@oauth, token_extract)
      end
    end

    private

    def refresh_token!
      return if !@oauth_token.expired?
      @oauth_token = @oauth_token.refresh_token
    end
  end
end

