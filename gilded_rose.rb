require 'bundler/setup'
require 'active_support/inflector'

Dir.glob(File.join(File.dirname(__FILE__), 'mechanics', '*')).each{|f| require f}

module Mechanics
  module Base
    def self.age(item)
      item.sell_in -= 1
    end
    def self.degrade(item)
      item.quality -= item.sell_in < 0 ? 2 : 1
      item.quality = [item.quality, 0].max
    end
  end
end

class GildedRose

  def initialize(items)
    @items = items
    mechanic_files = Dir.glob(File.join('mechanics', '*'))
    @mechanics = mechanic_files.map{|m| m.chomp(File.extname(m)).camelize.constantize}
  end

  def update_quality()
    @items.each do |item|
      mechanic = @mechanics.find{|m| m.matches?(item)} || Mechanics::Base
      mechanic.age(item)
      mechanic.degrade(item)
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
