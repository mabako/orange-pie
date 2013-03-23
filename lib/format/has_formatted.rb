class << ActiveRecord::Base
  # To use any of this, add a 'has_formatted :attributename' to the desired class.
  def has_formatted *attributes
    attributes.each do |attribute|
      name = attribute.to_sym

      attr_proc = lambda do
        # retrieve the original text
        text = self.send(name)

        # We could add other and/or multiple formatting options here some time in the future
        # Creole will mostly do for now.

        # However, there should be a support for internal links, i.e.
        #   [[Character:Diana Carvelli]] --> opens the according character page
        #   [[Wiki:San Fierro]] --> opens the according Wiki page
        #   [[Topic:id]] --> opens the according forum topic
        #   [[Blog:id]]
        # Likewise [[Character:...|Alternative Name]] should work

        Format::CreoleParser.new(text, :allowed_schemes => %w(http https)).to_html
      end

      # Creates a method of whatever options we got, prefixing it with formatted_
      self.send(:define_method, "formatted_#{name}", &attr_proc)
    end
  end
end
