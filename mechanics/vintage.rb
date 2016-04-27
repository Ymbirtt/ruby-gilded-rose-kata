module Mechanics
  module Vintage
    public
    def self.matches?(item)
      item.name == "Aged Brie"
    end
    def self.age(item)
      item.sell_in -= 1
    end
    def self.degrade(item)
      item.quality += item.sell_in < 0 ? 2 : 1
      item.quality = [item.quality, 50].min
    end
  end
end
