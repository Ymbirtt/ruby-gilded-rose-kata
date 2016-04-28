module Mechanics
  module Base
    public
    def self.matches?(item)
      true
    end
    def self.priority
      0
    end
    def age
      self.sell_in -= 1
    end
    def degrade
      self.quality -= self.sell_in < 0 ? 2 : 1
      self.quality = [self.quality, 0].max
    end
  end
end

