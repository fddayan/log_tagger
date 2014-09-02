module LogTagger
  class Plan
    COLORS =[:red, :green, :yellow, :blue, :magenta, :cyan, :white]

    def initialize(description, options)
      @description = description
      @match_tags = options[:include]

      # @uniq_tags = @match_tags.collect do |i|
      #   i[:include] + i[:exclude]
      # end.flatten.collect{|t| parse_tag(t)}.uniq

      @uniq_tags = @match_tags.collect {|e| e.tags }.flatten.uniq

      @colors = Hash[@uniq_tags.each_with_index.map do |item, index|
          [item,COLORS[index]]
      end]

      @uniq_tags.each do |t|
        raise "Tag #{t} does not exists" unless @description.rule?(t)
      end

      @options = options
    end

    def parse_tag(tag)
      if tag.to_s.start_with?("-")
        tag.to_s[1..-1].to_sym
      else
        tag
      end
    end

    def parse_include_exclude(tags)
      tags.partition {|t| t.start_with?("-")}
    end

    def tags_for_line(line)
      @description.matching_tags_for_line(@uniq_tags,line)
    end

    def parse_line(t,line)
      @description.parse_line(t,line)
    end

    def tags_colors
      @colors
    end

    def matches_any_tag_rule?(tag_entries)
      @match_tags.detect { |p| rule_matches(p, tag_entries.keys) }
    end

    def rule_matches(include_match,tag_keys)
      (include_match[:include].empty? || (include_match[:include] -  tag_keys).empty?) && (include_match[:exclude].empty? || !(include_match[:exclude] - tag_keys).empty? )
    end

    def match(line)
      tags_for_line = @description.matching_tags_for_line(@uniq_tags,line)
      match_tags_entry = @match_tags.detect { |e| e.match(tags_for_line) }

      if match_tags_entry
        tag_entries = @description.find_tag_entries(match_tags_entry.include_tags)

        return Match.new(line,match_tags_entry.display_tags, tag_entries,@options)
      else
        return nil
      end
    end

  end
end