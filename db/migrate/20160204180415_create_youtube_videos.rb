class CreateYoutubeVideos < ActiveRecord::Migration
  def change
    create_table :youtube_videos do |t|
      t.string :title
      t.string :url
      t.string :playlist_id
      t.string :video_id
      t.string :image
      t.references :youtube_channel, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
