module LogTagger

  def self.config
    @config ||= Config.new

    yield @config
  end

  def self.tags
    @config.tags
  end

  class Config

    def initialize
      @tags = {}
    end

    def define_tag(name, match_and_capture)
      case match_and_capture
      when Hash
        @tags[name] = { match: match_and_capture.first[0], capture: match_and_capture.first[1] }
      when Regexp
        @tags[name] = { match: match_and_capture }
      end
    end

    def tags
      @tags
    end
  end
end

