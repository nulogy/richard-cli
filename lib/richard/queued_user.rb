require 'json'

module Richard
  class QueuedUser
    attr_reader :user_id, :email, :name
    attr_reader :status

    def initialize(options)
      @user_id = options[:user_id]
      @name = options[:name]
      @email = options[:email]
      @status = options[:status]
    end

    def to_s
      [
        user_id,
        name,
        email,
        status
      ].join(", ")
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
          status: obj['status']
        )
      end
    end
  end
end