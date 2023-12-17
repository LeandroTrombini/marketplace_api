module Request
  module JsonHelpers
    def json_response(request = nil)
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end
  end
end