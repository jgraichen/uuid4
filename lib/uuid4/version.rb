class UUID4
  module VERSION
    MAJOR = 1
    MINOR = 3
    PATCH = 4
    STAGE = nil
    STRING = [MAJOR, MINOR, PATCH, STAGE].reject(&:nil?).join('.')

    def self.to_s
      STRING
    end
  end
end
