# Richard::Cli

Command line interface for accessing richard.

## Installation

Install it yourself as:

    $ gem install richard-cli

## Usage

    Usage:
      richard command [user_id]

    Commands:
      list - List current queue
      enqueue - Add yourself to the queue
      cancel - Cancel yourself from the queue if you are in nit
      run - Signal to the queue if you are running (only works if you are at the head of the queue)
      finish - Signal to the queue if you are finished (only works if you are at the head of the queue)
      force_release - Force releases another user.  The user_id must be provided.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/richard-cli/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
