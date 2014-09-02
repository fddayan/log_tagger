module LogTagger
  class Match
    def initialize(line,display, tag_entries,options)
      @tag_entries = tag_entries
      @line = line
      @display = display & @tag_entries.keys if display
      @options = options
    end

    def printout_tags
      @colored_tags ||= @tag_entries.values.collect(&:label).join
    end

    def printout_line
      if @display
        @display.collect do |d|
          "#{@tag_entries[d].parse_line(@line)}\t"
        end.join
      else
        @line
      end
    end

    def print_line
      # puts  "#{@tag_entries.keys}"
      if @options[:no_labels]
        puts "#{printout_line}"
      else
        puts "#{printout_tags}\t#{printout_line}"
      end
    end
  end
end