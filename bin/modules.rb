module Findable
  def find(list, name)
    list.select {|object| object.name == name}
  end
end