class AddSongToSongs < ActiveRecord::Migration
  def self.up
    add_attachment :songs, :song
  end

  def self.down
    remove_attachment :songs, :song
  end
end
