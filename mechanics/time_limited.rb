module Mechanics
  module TimeLimited
    def self.priority
      2
    end
    def self.matches?(item)
      item.name == "Backstage passes to a TAFKAL80ETC concert"
    end
    private
    def degrade
      case
      when self.sell_in < 0
        self.quality = 0
      when self.sell_in < 5
        self.quality += 3
      when self.sell_in < 10
        self.quality += 2
      else
        self.quality += 1
      end
    end
  end
end
