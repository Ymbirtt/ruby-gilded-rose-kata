 module Mechanics
   module Conjured
    def self.priority
      2
    end
    def self.matches?(item)
      item.name =~ /conjured/i
    end
    private
    def degrade
      self.quality -= self.sell_in < 0 ? 4 : 2
    end
   end
 end
