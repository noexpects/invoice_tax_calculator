# frozen_string_literal: true

require_relative 'lib/command_processor'

class Main
  def initialize
    @processor = CommandProcessor.new
  end

  def run
    print_banner

    loop do
      print "\n> "

      input = gets&.strip
      break if input == 'exit'

      processor.process(input)
    end

    puts 'Goodbye!'
  end

  private

  attr_reader :processor

  def print_banner
    puts 'Invoice tax calculator App'
    puts 'Supported commands: add_item, list_items, delete_item, generate_invoice, exit'
  end
end

Main.new.run if __FILE__ == $PROGRAM_NAME
