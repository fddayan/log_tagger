module LogTagger
  class TagEntry
    COLORS =[:red, :green, :yellow, :blue, :magenta, :cyan, :white]

    def initialize(name,attributes,options)
      @name = name
      @attributes = attributes
      @options = options
    end

    def match(line)
      line =~ @attributes[:match]
    end

    def name
      @name
    end

    def color
      if @options[:index] >= COLORS.size
        COLORS[@options[:index] % COLORS.size]
      else
        COLORS[@options[:index]]
      end
    end

    def parse_line(line)
      if @attributes[:capture]
        line.match(@attributes[:capture])[1]
      else
        line
      end
    end

    def match_regex
      @attributes[:match]
    end

    def label
      "[#{name}]".color(color)
    end

    def to_s
      "#{name} => #{[@attributes,@options]}"
    end

  end
end