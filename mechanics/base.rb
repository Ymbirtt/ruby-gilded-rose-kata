module Mechanics
  module Base
    def self.matches?(item)
      true
    end
    def self.priority
      0
    end
    private
    def age
      self.sell_in -= 1
    end
    def degrade
      self.quality -= self.sell_in < 0 ? 2 : 1
    end
    def clamp_quality
      self.quality = [self.quality, 0].max
      self.quality = [self.quality, 50].min
    end
    public
    def update
      age
      degrade
      clamp_quality
    end
  end
end

