require 'bundler/setup'
require 'active_support/inflector'

Dir.glob(File.join(File.dirname(__FILE__), 'mechanics', '*')).each{|f| require f}

class GildedRose

  def initialize(items)
    @items = items
    mechanic_files = Dir.glob(File.join('mechanics', '*'))
    @mechanics = mechanic_files.map{|m| m.chomp(File.extname(m)).camelize.constantize}.sort_by(&:priority)
  end

  def update_quality()
    @items.each do |item|
      @mechanics.each{|m| item.extend(m) if m.matches?(item)}
      item.age
      item.degrade
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
