class Feed < ActiveRecord::Base
  validates :title, presence: true
  validates :url, presence: true
  belongs_to :user

  def self.get_feed_items
    feed_items = []
    all.where(user_id: User.current.id).each do |x|
      feed = Feedjira::Feed.fetch_and_parse(x.url)
      feed.entries.each do |feed|
        feed_items << feed
      end
    end
    feed_items
  end
end
