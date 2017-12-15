class CreateSongGenres < ActiveRecord::Migration[5.1]
  def change
    create_table :song_genres do |t|
      t.string :genre_id
      t.integer :song_id
    end
  end
end
