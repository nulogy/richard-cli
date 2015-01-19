module Richard
  class Config
    attr_reader :api_key, :url

    DEFAULT_URL = "http://richard.nulogy.nu"
    CONFIG_FILE = ENV['HOME'] + "/.richard"

    def initialize(url, api_key)
      @url = url
      @api_key = api_key
    end
  end
end