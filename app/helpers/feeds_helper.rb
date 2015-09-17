module FeedsHelper

  def fetch_feed_items(feeds)
    feeds.each do |feed|
      latest_item = feed.items.find_by(published: feed.items.maximum(:published)) 
      parsed_feed = Feedjira::Feed.fetch_and_parse(feed.url)
      store_items(parsed_feed, latest_item, feed)
    end
  end

  def store_items(parsed_feed, latest_item, feed)
    parsed_feed.entries.each do |item|
      break if latest_item && item.title == latest_item.title
      Item.create(title: item.title, url: item.url,
                  published: item.published, feed_id: feed.id)
    end
  end

  def file_param_exists? 
    !params[:feed][:file].nil?
  end

  def setup_file_for_searching
    file = params[:feed][:file].read
    Nokogiri::XML(file)
  end

  def save_outlines_from_opml(opml_doc)
    opml_doc.xpath("/opml/body/outline/outline").each do |outline|
      @feed = current_user.feeds.build(title: outline[:title], url: outline[:xmlUrl])
      @feed.save
    end
  end

end
