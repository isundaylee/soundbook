class PlayerController < ApplicationController
  def index
    song_id = params[:reveal]

    if song_id
      @song = Song.find(song_id) rescue nil
      @album = @song.album if @song
    end

    render layout: false
  end
end
