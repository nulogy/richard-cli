require 'terminal-table'

module Richard
  module QueuedUserFormatter
    extend self

    def table_format(users)
      # return Terminal::Table.new(rows: rows)
      Terminal::Table.new do |table|
        table << row_header
        table.add_separator

        users.each { |user| table << user_to_row(user) }
      end
    end

    def row_header
      [
        "User Id",
        "User",
        "Status",
        "Blocking Duration"
      ]
    end

    def user_to_row(user)
      return [
        user.user_id,
        user.email,
        user.status,
        format_duration(user.blocking_duration)
      ]
    end

    def format_duration(duration)
      (duration) ? Time.at(duration).utc.strftime("%Hh %Mm %Ss") : '--'
    end
  end
end