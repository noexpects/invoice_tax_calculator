# frozen_string_literal: true

class Receipt
  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(item)
    items << item
  end

  def delete_item(index)
    items.delete_at(index)
  end

  def sales_taxes
    items.sum(&:sales_tax)
  end

  def total
    items.sum(&:total_price)
  end
end
