# frozen_string_literal: true

class UUID4
  module VERSION
    MAJOR = 1
    MINOR = 4
    PATCH = 1
    STAGE = nil
    STRING = [MAJOR, MINOR, PATCH, STAGE].compact.join('.')

    def self.to_s
      STRING
    end
  end
end
