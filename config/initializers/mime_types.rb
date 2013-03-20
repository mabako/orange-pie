# Be sure to restart your server when you modify this file.

# Nobody wants XML, we got JSON. As nobody is really dependent on any existing XML-based structure, it shouldn't really bother anyone either.
ActionDispatch::ParamsParser::DEFAULT_PARSERS.delete(Mime::XML)

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register_alias "text/html", :iphone
