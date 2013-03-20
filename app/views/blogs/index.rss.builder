xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title t('title1') + ' ' + t('title2')
    xml.description "The Blog"
    xml.link blogs_url

    for blog in @blogs
      xml.item do
        xml.title blog.title
        xml.description blog.text
        xml.pubDate blog.created_at.to_s(:rfc822)
        xml.link blog_url(blog)
        xml.guid blog_url(blog)
      end
    end
  end
end