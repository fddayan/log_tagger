module LogTagger

  class TagsDescription
    def initialize(rules)
      @rules = Hash[rules.each_with_index.map{ |e,index|  [e[0],TagEntry.new(e[0],e[1], index: index)] }]
    end

    def matches(line)
      @rules.values.select{|r| r.match(line)}
    end

    def rule(name)
      @rules[name]
    end

    def names
      @rules.values.collect(&:name).uniq
    end

    def matching_tags_for_line(tags, line)
      tags.select do |t|
        rule(t).match(line)
      end
    end

    def rule?(name)
      @rules.key?(name)
    end

    def parse_line(rule_name,line)
      rule(rule_name).parse_line(line)
    end

    def printout_tag_labels(tags_names)
      tags_names.collect do |tag_name|
        "[#{tag_name}]".color(@rules[tag_name].color)
      end.join
    end

    def matching_tag_entries_for_line(tags, line)
      Hash[@rules.select do |name, tag_entry|
        tags.include?(name)
      end.select do |name, tag_entry|
        tag_entry.match(line)
      end]
    end

    def find_tag_entries(tags)
      Hash[tags.collect{ |t| [t, rule(t)] }]
    end

  end
end
