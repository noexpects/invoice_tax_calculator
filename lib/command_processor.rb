# frozen_string_literal: true

require_relative 'item'
require_relative 'receipt'
require_relative 'input_validator'
require_relative 'printer'

class CommandProcessor
  attr_reader :receipt, :printer

  def initialize
    @receipt = Receipt.new
    @printer = Printer.new
  end

  def process(input)
    validation = InputValidator.validate_input(input)
    return if print_validation_errors(validation)

    case input
    when /^add_item\s+(.+)$/
      handle_add_item(Regexp.last_match(1))
    when 'list_items'
      handle_list_items
    when /^delete_item\s+(\d+)$/
      handle_delete_item(Regexp.last_match(1).to_i)
    when 'generate_invoice'
      handle_generate_invoice
    else
      printer.print_message('Unknown command')
    end
  end

  private

  def handle_add_item(data)
    validation = InputValidator.validate_add_item(data)
    return if print_validation_errors(validation)

    item = Item.new(
      quantity: validation.data[:quantity],
      name: validation.data[:name],
      price: validation.data[:price]
    )

    receipt.add_item(item)
    printer.print_message('Item added')
  end

  def handle_list_items
    printer.print_items_list(receipt.items)
  end

  def handle_delete_item(index)
    validation = InputValidator.validate_delete_item(index, receipt.items)
    return if print_validation_errors(validation)

    deleted_item = receipt.delete_item(index)
    printer.print_deleted_item(deleted_item.name)
  end

  def handle_generate_invoice
    printer.print_receipt(receipt)
  end

  def print_validation_errors(validation)
    return false if validation.valid?

    printer.print_errors(validation.errors)

    true
  end
end
