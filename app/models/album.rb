class Album < ActiveRecord::Base
  require 'uri'

  scope :visible, -> { where(hidden: false) }
  has_many :songs

  has_attached_file :cover, styles: { medium: '300x300>', thumb: '100x100>'}
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

  def cover_url
    if Settings.is_mirror
      local = File.join(Rails.root, 'public', URI.decode(cover.url).split('?')[0])
      remote = URI.join(Settings.mirror_src, cover.url)

      File.exists?(local) ? cover.url : remote
    else
      cover.url
    end
  end
end
