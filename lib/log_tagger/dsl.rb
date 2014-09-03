module LogTagger
  @registry = {}

  def self.definitions
    @registry
  end

  class DefinitionProxy
    def tag(name, regex)
      # puts "Defining #{name} and #{match_and_capture}"

      LogTagger.definitions[name] = { match: regex, capture: regex }
      # case match_and_capture
      # when Hash
      #   LogTagger.definitions[name] = { match: match_and_capture.first[0], capture: match_and_capture.first[1] }
      # when Regexp
      #   LogTagger.definitions[name] = { match: match_and_capture }
      # end
    end
  end

  def self.define(&block)
    definition_proxy = DefinitionProxy.new(&block)
    definition_proxy.instance_eval(&block)
  end

  # def self.config
  #   @config ||= Config.new

  #   yield @config
  # end

  # def self.tags
  #   self.definitions
  # end

  # class Config

  #   def initialize
  #     @tags = {}
  #   end

  #   def define_tag(name, match_and_capture)
  #     case match_and_capture
  #     when Hash
  #       @tags[name] = { match: match_and_capture.first[0], capture: match_and_capture.first[1] }
  #     when Regexp
  #       @tags[name] = { match: match_and_capture }
  #     end
  #   end

  #   def tags
  #     @tags
  #   end
  # end
end

