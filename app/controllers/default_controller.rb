require "httparty"

class DefaultController < ApplicationController
  def home
    if access_token
      @profiles = HTTParty.get(profiles_url,
        :query => {:access_token => access_token}
      ).parsed_response
    end
  end

private

  def access_token
    session[:access_token]
  end

  SINGLY_API_BASE = "https://api.singly.com"

  def profiles_url
    "#{SINGLY_API_BASE}/profiles"
  end

  def auth_url(service)
    url = "/auth/singly?service=#{service}"
    url << "&access_token=#{access_token}" if access_token
    url
  end
  helper_method :auth_url
end
