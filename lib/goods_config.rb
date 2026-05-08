# frozen_string_literal: true

require 'yaml'

class GoodsConfig
  CONFIG_PATH = File.expand_path('../data/goods_config.yaml', __dir__)

  class << self
    def data
      @data ||= YAML.load_file(CONFIG_PATH)
    end

    def basic_tax_rate
      data['basic_tax_rate'].to_f
    end

    def import_duty_rate
      data['import_duty_rate'].to_f
    end

    def exempt?(name)
      exempt_keywords.any? { |keyword| name.include?(keyword) }
    end

    def valid_good?(name)
      goods.include?(name)
    end

    private

    def exempt_keywords
      data['exempt_keywords']
    end

    def goods
      data['goods']
    end
  end
end
