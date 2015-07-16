$ ->
  # preload all zoom-images
  $('*[data-magnifierjs-zoomimage]').each (el) ->
    $('<img/>')[0].src = $(this).data('magnifierjs-zoomimage')

  image = $("#magnifierjs-image")
  return unless image.size()
  larW  = 0
  larH  = 0

  glass = $('<div id="magnifierjs-glass"></div>').appendTo($('body'))

  setLargeSrc = () ->
    largeSrc  = image.data('magnifierjs-zoomimage')

    loader = $('<img>')
    loader.load -> 
      larW = this.width
      larH = this.height
    loader.attr('src', largeSrc)
    glass.css 'background-image': "url("+largeSrc+")"

  setLargeSrc()

  # show the glass only when everything is loaded
  $(window).load ->
    image.mouseover ->
      setLargeSrc()
      $(document).mousemove(moveGlass)
      glass.fadeIn('slow')

  moveGlass = (e) ->
    imgW = image.width()
    imgH = image.height()
    imgX = image.offset().left
    imgY = image.offset().top

    curX = e.pageX
    curY = e.pageY

    glaX = curX - glass.width() / 2
    glaY = curY - glass.width() / 2

    innX = curX - imgX
    innY = curY - imgY

    bgX  = glass.width() / 2 - innX * larW / imgW
    bgY  = glass.height()/ 2 - innY * larH / imgH
    # console.log larW+" "+larH+" "+bgX+" "+bgY

    glass.css
      'left': glaX
      'top':  glaY
      'background-position': bgX+"px "+bgY+"px"

    # console.log imgX+" "+curX+" "+(imgX + imgW)+"  | "+imgY+" "+curY+" "+(imgY + imgH)
    if (curX < imgX) || (curY < imgY) || (curX > (imgX + imgW)) || (curY > (imgY + imgH))
      # console.log "OUT >>"
      $(document).unbind('mousemove', moveGlass)
      glass.fadeOut('fast')