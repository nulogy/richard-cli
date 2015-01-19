require 'json'

module Richard
  class QueuedUser
    attr_reader :user_id, :email, :name
    attr_reader :status, :blocking_duration

    def initialize(options)
      @user_id = options[:user_id]
      @name = options[:name]
      @email = options[:email]
      @status = options[:status]
      @blocking_duration = options[:blocking_duration]
    end
  end

  module QueuedUserDeserializer
    extend self

    def from_json(parsed_json)
      parsed_json['content'].map do |obj|
        obj = obj['queue_transaction']

        Richard::QueuedUser.new(
          user_id: obj['user']['id'],
          name: obj['user']['name'],
          email: obj['user']['email'],
          status: obj['status'],
          blocking_duration: obj['blocking_duration']
        )
      end
    end
  end
end