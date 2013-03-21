require 'creole'

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

        # It may be semantically desirable to have the headings replaced with
        # lower headings, i.e.
        #   = -> h2 instead of h1
        #   == -> h3 instead of h2
        #   === -> h4 instead of h3
        Creole.creolize(text, :allowed_schemes => %w(http https))
      end

      # Creates a method of whatever options we got, prefixing it with formatted_
      self.send(:define_method, "formatted_#{name}", &attr_proc)
    end
  end
end
