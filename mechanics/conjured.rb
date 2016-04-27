 module Mechanics
   module Conjured
    def self.matches?(item)
      item.name =~ /conjured/i
    end
    def self.age(item)
      item.sell_in -= 1
    end
    def self.degrade(item)
      item.quality -= item.sell_in < 0 ? 4 : 2
      item.quality = [item.quality, 0].max
    end
   end
 end
