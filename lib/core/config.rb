class Config
  ACTIONS = [
    { full: 'list',  short: 'L', description: 'Show product list' },
    { full: 'rules', short: 'R', description: 'View pricing rules for delivery' },
    { full: 'add',   short: 'A', description: 'Add items to basket' },
    { full: 'quit',  short: 'Q', description: 'Exit program' }
  ].freeze

  class << self
    def actions
      ACTIONS.each_with_object({}) { |a, h| h[a[:full]] = a[:short] }
    end

    def full_actions
      actions.keys
    end

    def short_actions
      actions.values
    end

    def valid_action?(input)
      return nil if input.nil? || input.strip.empty?

      action = nil
      if actions.key?(input.downcase)
        action = input.downcase
      elsif actions.value?(input.upcase)
        action = actions.key(input.upcase)
      end
      action
    end

    def show_actions_details
      puts "\nUSE FOLLOWING COMMAND:\n\n"
      ACTIONS.each do |action|
        puts "  #{action[:full].ljust(6)} (#{action[:short]}): #{action[:description]}"
      end
      puts "\n"
    end
  end
end
