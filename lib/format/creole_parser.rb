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

    # emoticon support, the hacky way
    def make_emoticon image, alt
      '<img src="' << escape_html("/emoticons/#{image}.png") << '" alt="' << escape_html(alt) << '" title="' << escape_html(alt) << '"/>'
    end
    
    alias :super_parse_inline_tag :parse_inline_tag

    def parse_inline_tag str
      # original
      case str
      when /\A\{\{\{(.*?\}*)\}\}\}/
        @out << '<tt>' << escape_html($1) << '</tt>'
      when /\A\{\{\s*(.*?)\s*(\|\s*(.*?)\s*)?\}\}/
        if uri = make_image_link($1)
          @out << make_image(uri, $3)
        else
          @out << escape_html($&)
        end

      # custom!
      when /\A\:\)/ # :)
        @out << make_emoticon('smiling', $&)
      when /\A>\:\(/ # >:(
        @out << make_emoticon('angry', $&)
      when /\A\:\(/ # :(
        @out << make_emoticon('frowning', $&)
      when /\A\:x/ # :x
        @out << make_emoticon('lips_sealed', $&)
      when /\A\:(p|P)/ # :P :p
        @out << make_emoticon('tongue_out', $&)
      when /\A\:\|/ # :|
        @out << make_emoticon('speechless', $&)
      when /\A(D\:|\:@)/ # D: :@
        @out << make_emoticon('terrified', $&)
      when /\Ao\.O/ # o.O
        @out << make_emoticon('surprised', $&)
      when /\AO\.o/ # O.o
        @out << make_emoticon('surprised_2', $&)
      when /\A\:3/ # :3
        @out << make_emoticon('aww', $&)
      when /\A\:(S|s)/ # :S :s
        @out << make_emoticon('confused', $&)
      when /\A\:O/ # :O
        @out << make_emoticon('gasping', $&)
      when /\A\:D/ # :D
        @out << make_emoticon('grinning', $&)
      when /\A<3/ # <3
        @out << make_emoticon('heart', $&)
      when /\A>_</ # >_<
        @out << make_emoticon('irritated', $&)
      when /\A>\.</ # >.<
        @out << make_emoticon('irritated_2', $&)
      when /\AxD/ # xD
        @out << make_emoticon('laughing', $&)
      when /\AxP/ # xP
        @out << make_emoticon('tongue_out_laughing', $&)
      when /\A\:\// # :/
        @out << make_emoticon('unsure', $&)
      when /\A\:\\/ # :\
        @out << make_emoticon('unsure_2', $&)
      when /\A;\)/ # ;)
        @out << make_emoticon('winking', $&)
      when /\A\;D/ # ;D
        @out << make_emoticon('winking_grinning', $&)
      when /\A\;P/ # ;P
        @out << make_emoticon('winking_tongue_out', $&)
      else
        super_parse_inline_tag str
      end
    end
  end
end
