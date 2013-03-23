require 'creole'

module Format
  class CreoleParser < Creole::Parser
    alias :super_headline :make_headline

    # Limit the available headlines to:
    #   = -> h2
    #   == -> h3
    #   === and more -> h4
    def make_headline level, text
      super_headline([4, level + 1].min, text)
    end
  end
end
