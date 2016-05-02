module Mechanics
  module Vintage
    public
    def self.matches?(item)
      item.name == "Aged Brie"
    end
    def self.priority
      2
    end
    private
    def degrade
      self.quality += self.sell_in < 0 ? 2 : 1
    end
  end
end
