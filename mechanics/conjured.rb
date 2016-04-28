 module Mechanics
   module Conjured
    def self.priority
      2
    end
    def self.matches?(item)
      item.name =~ /conjured/i
    end
    def degrade
      self.quality -= self.sell_in < 0 ? 4 : 2
      self.quality = [self.quality, 0].max
    end
   end
 end
