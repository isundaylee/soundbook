# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this

init_player_index = ->
  # Center albums
  center_albums = ->
    albums_div = $('#albums')
    albums_div.css('top', ($(window).height() - albums_div.height()) / 2)
    albums_div.css('left', ($(window).width() - albums_div.width()) / 2)
  center_panels = ->
    $('.album-songlist').css('margin-left', ($(window).width() - $('.album-songlist').width() - $('#player').width()) / 2)

  center_albums()
  center_panels()
  $(window).resize center_albums
  $(window).resize center_panels

  root.show_album_songlist = (id) ->
    $('#albums-songlist').show()
    $('#album-songlist-' + id).css('display', 'inline-block');

  root.hide_album_songlist = ->
    $('#albums-songlist').hide()
    $('.album-songlist').hide()

  root.play_song = (id) ->
    alert('Should be playing song ' + id)

  null_clicking = (event) ->
    event.stopPropagation()

  $('#albums-songlist').click root.hide_album_songlist
  $('.album-songlist').click null_clicking
  $('#player').click null_clicking

$(document).ready ->
  if $('body#index').size() > 0
    init_player_index()
    show_album_songlist(1)

