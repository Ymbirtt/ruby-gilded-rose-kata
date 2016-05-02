module Mechanics
  module Legendary
    def self.matches?(item)
      item.name == "Sulfuras, Hand of Ragnaros"
    end
    def self.priority
      1
    end
    public
    def update
    end
  end
end
