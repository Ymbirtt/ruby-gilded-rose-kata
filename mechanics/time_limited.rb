module Mechanics
  module TimeLimited
    def self.matches?(item)
      item.name == "Backstage passes to a TAFKAL80ETC concert"
    end
    def self.age(item)
      item.sell_in -= 1
    end
    def self.degrade(item)
      case
      when item.sell_in < 0
        item.quality = 0
      when item.sell_in < 5
        item.quality += 3
      when item.sell_in < 10
        item.quality += 2
      else
        item.quality += 1
      end
      item.quality = [item.quality, 50].min
    end
  end
end
