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
        "Name",
        "Email",
        "Status"
      ]
    end

    def user_to_row(user)
      return [
        user.user_id,
        user.name,
        user.email,
        user.status
      ]
    end
  end
end