class Item
  attr_reader :name, :description

  def initialize(name, terms, description)
    @name = name
    @terms = terms
    @description = description
  end

  def describe_object
    puts description
  end
end