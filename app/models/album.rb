class Album < ActiveRecord::Base
  require 'uri'

  scope :visible, -> { where(hidden: false) }
  has_many :songs

  has_attached_file :cover, styles: { medium: '300x300>', thumb: '100x100>'}
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

  def cover_url
    if Settings.is_mirror
      url = cover.url(:medium)

      local = File.join(Rails.root, 'public', URI.decode(url).split('?')[0])
      remote = URI.join(Settings.mirror_src, url)

      File.exists?(local) ? url : remote
    else
      cover.url(:medium)
    end
  end
end
