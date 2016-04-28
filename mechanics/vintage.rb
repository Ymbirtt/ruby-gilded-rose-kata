module Mechanics
  module Vintage
    public
    def self.matches?(item)
      item.name == "Aged Brie"
    end
    def self.priority
      2
    end
    def degrade
      self.quality += self.sell_in < 0 ? 2 : 1
      self.quality = [self.quality, 50].min
    end
  end
end
