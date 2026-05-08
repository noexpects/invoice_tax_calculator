# frozen_string_literal: true

require_relative 'goods_config'

class TaxCalculator
  ROUNDING_FACTOR = 20.0

  class << self
    def calculate(item)
      tax_rate = 0

      tax_rate += GoodsConfig.basic_tax_rate unless GoodsConfig.exempt?(item.name)
      tax_rate += GoodsConfig.import_duty_rate if item.imported?

      round_tax(item.price * tax_rate) * item.quantity
    end

    private

    def round_tax(amount)
      (amount * ROUNDING_FACTOR).ceil / ROUNDING_FACTOR
    end
  end
end
