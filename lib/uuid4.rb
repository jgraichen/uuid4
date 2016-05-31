require 'uuid4/version'

class UUID4
  module Formatter
    require 'uuid4/formatter/default'
    require 'uuid4/formatter/compact'
    require 'uuid4/formatter/base62'
    require 'uuid4/formatter/urn'
  end

  FORMATTERS = [
    Formatter::Default.new,
    Formatter::Compact.new,
    Formatter::URN.new,
    Formatter::Base62.new
  ]

  def initialize(value)
    @value = value
  end

  def ==(other)
    return value === other.to_i if other.is_a?(UUID4)
    return other.to_uuid4 == self if other.respond_to?(:to_uuid4)

    self.class._parse(other) === value
  end

  def to_str(format: :default, formatter: nil)
    case format
      when :default
        formatter = FORMATTERS[0]
      when :compact
        formatter = FORMATTERS[1]
      when :urn
        formatter = FORMATTERS[2]
      when :base62
        formatter = FORMATTERS[3]
      else
        raise RuntimeError.new("Unknown format: #{format}")
    end

    formatter.encode(self)
  end

  alias_method :to_s, :to_str
  alias_method :to_uuid, :to_str

  def to_uuid4
    self
  end

  def to_int
    @value
  end

  alias_method :to_i, :to_int

  def inspect
    "<UUID4:#{to_s}>"
  end

  def components
    [
      (value >> 96) & 0xFFFFFFFF,
      (value >> 80) & 0xFFFF,
      (value >> 64) & 0xFFFF,
      (value >> 48) & 0xFFFF,
      (value >> 0)  & 0xFFFFFFFFFFFF
    ]
  end

  protected

  attr_reader :value

  class << self
    def new(value = nil)
      if value.nil?
        super(SecureRandom.uuid.tr('-', '').hex)
      elsif value.is_a?(UUID4)
        value
      elsif value.respond_to?(:to_uuid4)
        value.to_uuid4
      elsif value.respond_to?(:to_int) && valid_int?(value = value.to_int)
        super(value)
      elsif (ret = _parse(value))
        super(ret)
      else
        raise TypeError.new "Invalid UUID: #{value.inspect}"
      end
    end

    def _parse(value)
      if value.respond_to?(:to_int) && valid_int?(value = value.to_int)
        return value
      end

      FORMATTERS.each do |formatter|
        val = formatter.decode(value) if formatter.respond_to?(:decode)
        return val if val
      end

      nil
    end

    def valid_int?(int)
      int.to_s(16) =~ Formatter::Compact::REGEXP
    end
  end
end

module Kernel
  def UUID4(value)
    UUID4.new(value)
  end

  def UUID(value)
    UUID4.new(value)
  end
end
