# frozen_string_literal: true

class ValidationResult
  attr_reader :errors
  attr_accessor :data

  def initialize
    @errors = []
    @data = nil
  end

  def add_error(message)
    errors << message
  end

  def valid?
    errors.empty?
  end
end
