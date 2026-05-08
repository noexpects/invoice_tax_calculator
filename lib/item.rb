# frozen_string_literal: true

require_relative 'tax_calculator'

class Item
  attr_reader :quantity, :name, :price, :sales_tax

  def initialize(quantity:, name:, price:)
    @quantity = quantity
    @name = name
    @price = price
    @sales_tax = TaxCalculator.calculate(self)
  end

  def to_s
    "#{quantity} #{name} at #{price}"
  end

  def imported?
    name.include?('imported')
  end

  def total_price
    (price * quantity) + sales_tax
  end
end
