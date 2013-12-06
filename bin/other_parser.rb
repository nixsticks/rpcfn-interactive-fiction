class Parser
  attr_reader :file

  def initialize(file)
    @file = File.new(file)
  end

  def options
    options = Hash.new()
    all_actions = /Synonyms:([\W\w]*)/.match(file.read)[1].split("\n")
    all_actions.delete("")
    all_actions.map {|action| action.gsub(/\s{2,}/, "").split(/[:,]\s/)}
    all_actions.each {|action| options[action[0]] = action[1..action.length]}
    options
  end

  def find_object(object)
    if all_sections.scan(/$(.*)*/).flatten.include?(object)
      description = object.scan()
    end
  end
end

parser = Parser.new('../data/petite_cave.if')
p parser.options