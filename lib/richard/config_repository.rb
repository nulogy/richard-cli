require 'yaml'
require 'highline/import'

module Richard
  module ConfigRepository
    extend self

    def find_or_create
      load || prompt
    end

    def prompt
      puts "Could not find a valid config file.  Creating one at #{Config::CONFIG_FILE}"

      url = ask "URL for Richard: " do |q|
        q.default = Richard::Config::DEFAULT_URL
      end

      api_key = ask "API Key: " do |q|
        q.validate = /\w+/
      end

      config = Config.new(url, api_key)
      save(config)

      return config
    end


    def load
      return YAML.load_file(Config::CONFIG_FILE)
    rescue Errno::ENOENT => e
      return false
    end

    def save(config)
      File.open(Config::CONFIG_FILE, 'w') do |file|
        file.write(YAML.dump(config))
      end
    end
  end
end