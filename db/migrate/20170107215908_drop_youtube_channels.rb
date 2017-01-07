class DropYoutubeChannels < ActivRecord::Migration[5.0]
  def change
    drop_table :youtube_channels do |t|
      t.string :title
      t.string :channel_id
      t.string :url
      t.string :video_count

      t.timestamps null: false
    end
  end
end
