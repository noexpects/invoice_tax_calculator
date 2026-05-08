# frozen_string_literal: true

require_relative 'validation_result'
require_relative 'goods_config'

class InputValidator
  ADD_ITEM_REGEX = /^(-?\d+)\s+(.+)\s+at\s+(-?\d+(\.\d+)?)$/.freeze

  def self.validate_input(input)
    result = ValidationResult.new
    result.add_error('Empty input') if input.nil? || input.strip.empty?

    result
  end

  def self.validate_add_item(data)
    result = ValidationResult.new
    match = data.match(ADD_ITEM_REGEX)

    unless match
      result.add_error('Invalid input format')
      return result
    end

    quantity = match[1].to_i
    name = match[2].strip.downcase
    price = match[3].to_f

    result.add_error('Quantity must be greater than 0') if quantity <= 0
    result.add_error('Price must be greater than 0') if price <= 0

    unless GoodsConfig.valid_good?(name.gsub('imported', '').strip.gsub(/\s+/, ' '))
      result.add_error('Invalid item entries')
    end

    result.data = { quantity: quantity, name: name, price: price }

    result
  end

  def self.validate_delete_item(index, items)
    result = ValidationResult.new

    result.add_error('Invalid item index') if index.negative?
    result.add_error('Item does not exist') if items[index].nil?

    result
  end
end
