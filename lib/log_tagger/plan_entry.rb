module LogTagger
  class PlanEntry
    def initialize(string_entry)
      include_and_display = string_entry.split(":")
      include_matches = include_and_display[0].split(",")
      display_with    = include_and_display[1].split(",") if include_and_display[1]
      i = include_matches.partition{ |t| t.start_with?("-") }
      @entry = {}
      @entry[:exclude] = i[0].collect{ |t| t[1..-1].to_sym }
      @entry[:include] = i[1].collect(&:to_sym)
      @entry[:display] = display_with.collect(&:to_sym) if display_with
      # @entry = entry
    end

    def entry
      @entry
    end

    def tags
      (@entry[:include] + @entry[:exclude]).collect{ |t| parse_tag(t) }
    end

    def parse_tag(tag)
      if tag.to_s.start_with?("-")
        tag.to_s[1..-1].to_sym
      else
        tag
      end
    end

    def include_tags
      @entry[:include]
    end

    def display_tags
      @entry[:display]
    end

    def match(tag_keys)
      (@entry[:include].empty? || (@entry[:include] -  tag_keys).empty?) && (@entry[:exclude].empty? || !(@entry[:exclude] - tag_keys).empty? )
    end
  end
end