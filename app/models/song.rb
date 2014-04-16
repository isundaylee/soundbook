class Song < ActiveRecord::Base
  belongs_to :album

  has_attached_file :song
  validates_attachment_content_type :song, content_type: ['audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio']

  def song_url
    if Settings.is_mirror
      local = File.join(Rails.root, 'public', URI.decode(song.url).split('?')[0])
      remote = URI.join(Settings.mirror_src, song.url)

      File.exists?(local) ? song.url : remote.to_s
    else
      song.url
    end
  end
end
