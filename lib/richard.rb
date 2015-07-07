require "richard/version"
require "richard/config"
require "richard/config_repository"
require "richard/queued_user"
require "richard/queued_user_formatter"

require "rest-client"

module Richard
  class Server
    def initialize(base_url, api_key)
      @base_url = base_url
      @api_key = api_key
    end

    def grab
      response = send_command("/queue/grab.json")
      print_result(response)
    end

    def release
      response = send_command("/queue/release.json")
      print_result(response)
    end

    def force_release(user_id)
      response = send_command("/queue/force_release/#{user_id}.json")
      print_result(response)
    end

    def list
      print_result(RestClient.get(@base_url + "/?format=json&api_key=#{@api_key}"))
    end

  private

    def send_command(url)
      RestClient.post(@base_url + url, api_key: @api_key)
    rescue RestClient::UnprocessableEntity => e
      e.response
    end

    def print_result(result)
      json = JSON.parse(result)

      users = QueuedUserDeserializer.from_json(json)

      puts QueuedUserFormatter.table_format(users)
      puts format_estimated_wait(json)
      puts format_flash(json['flash']) unless json['flash'].empty?
    end

    def format_estimated_wait(response)
      seconds = response['estimated_wait_time']
      wait_time = Time.at(seconds).utc.strftime("%Hh %Mm %Ss")
      "Estimated Wait: #{wait_time}"
    end

    def format_flash(flash)
      if flash['error']
        "\nError: " + flash['error']
      end
    end
  end


end
