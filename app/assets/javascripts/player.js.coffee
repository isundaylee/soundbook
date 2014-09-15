# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this

init_player_index = ->
  is_small_screen = ->
    return ($(window).width() < 1000)

  if is_small_screen()
    alert('将浏览器窗口宽度调至 1000 像素或更高才会看得到最好的效果哦\nBest viewed at width of 1000 pixels or more! ')

  # Center albums
  center_albums = ->
    albums_div = $('#albums')
    albums_div.css('top', ($(window).height() - albums_div.outerHeight()) / 2)
    albums_div.css('left', ($(window).width() - albums_div.outerWidth()) / 2)
  center_panels = ->
    if is_small_screen()
      $('.player_alt').show()
      $('#player').hide()
      $('.album-songlist').css('margin-left', ($(window).width() - $('.album-songlist').outerWidth()) / 2)
    else
      $('.player_alt').hide()
      $('#player').show()
      $('.album-songlist').css('margin-left', ($(window).width() - $('.album-songlist').outerWidth() - $('#player').outerWidth()) / 2)
      $('#description').css('height', $(window).height() - 220)

  # Initialiazing player
  $('#jplayer').jPlayer({
    ready: ->
    supplied: 'mp3',
    cssSelectorAncestor: '',
    cssSelector: {
      play: '.play',
      pause: '.pause',
      stop: '.stop',
      currentTime: ".currentTime",
      duration: ".duration"
    },
    timeupdate: (event) ->
      duration = event.jPlayer.status.duration
      current = event.jPlayer.status.currentTime
      ratio = 0

      if (duration == 0)
        ratio = 0
      else
        ratio = 100 * current / duration

      $('.progress').css('width', parseInt(ratio) + '%')
  })

  $('.progress_border').click (e) ->
    pos = e.pageX - $(this).offset().left
    ratio = 100.0 * pos / $(this).width()

    if (ratio < 0)
      ratio = 0
    if (ratio > 100)
      ratio = 100

    $('#jplayer').jPlayer('playHead', parseInt(ratio))

  # Arrange panels
  center_albums()
  center_panels()
  $(window).resize center_albums
  $(window).resize center_panels

  root.show_album_songlist = (id) ->
    $('#album-songlists').show()
    $('#album-songlist-' + id).css('display', 'inline-block');

  root.hide_album_songlist = ->
    $('#album-songlists').hide()
    $('.album-songlist').hide()

  root.play_song = (id) ->
    path = Routes.song_path(id, {format: 'json'})
    $.get(path, (data) ->
      nl2br = (str, is_xhtml) ->
        breakTag = '<br>'
        (str + '').replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1' + breakTag + '$2');

      url = data['song']
      desc = data['description']

      if !desc
        desc = '该歌曲无介绍显示'

      $('#jplayer').jPlayer('setMedia', {mp3: url}).jPlayer('play')
      $('#description').html(nl2br(desc))
    )

  null_clicking = (event) ->
    event.stopPropagation()

  $('#album-songlists').click root.hide_album_songlist
  $('.album-songlist').click null_clicking
  $('#player').click null_clicking

$(document).ready ->
  if $('body#index').size() > 0
    init_player_index()

