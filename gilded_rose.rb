require 'bundler/setup'
require 'active_support/inflector'

Dir.glob(File.join(File.dirname(__FILE__), 'mechanics', '*')).each{|f| require f}

class GildedRose

  def initialize(items)
    @items = items
    mechanics = load_mechanics
    @items.each do |item|
      mechanics.each{|m| item.extend(m) if m.matches?(item)}
    end
  end

  def update_quality
    @items.each(&:update)
  end

  private
  def load_mechanics
    Dir.glob(File.join('mechanics', '*')).map{|mechanic_file| load_mechanic_from(mechanic_file)}.sort_by(&:priority)
  end

  def load_mechanic_from(file_name)
    constant_name = file_name.chomp(File.extname(file_name)).camelize
    begin
      constant_name.constantize
    rescue NameError
      raise LoadError, "Expected #{file_name} to define #{constant_name}"
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
