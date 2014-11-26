###############################
## Base game Object definitions
###############################
#@Animation = class _Animation
#  constructor: (image, steps_duration) ->
#    @parent = null
#    @frames = 0
#    @img = pinst.loadImage(image)
#    @steps_duration = steps_duration
#
#  draw: ->
#    # Draw an animation on parent position
#    if @parent != null
#      x = @parent.posx * window.tile_width
#      y = @parent.posy * window.tile_height
#      pinst.image(@img, x, y, window.tile_width, window.tile_height)
#
#  frame: ->
#    # When frame happens, lower the duration steps
#    # If there is no more duration steps.. remove from game
#    @steps_duration -= 1
#    if @steps_duration == 0
#      @parent.remove_animation()


@GameObject = class
  constructor: () ->
    # position - reference to a Polygon plus actual position (for movement)
    @posX = -1
    @posY = -1
    @polygon = null

    # image for outputting to the game
    @img = null

    @pr = window.pinst
    @font = @pr.loadFont('Arial')
    @animation = null
    @hidden = false

  setPos: (p) ->
    # Sets position to a specific polygon
    @polygon = p
    @posX = p.getX()
    @posY = p.getY()

#  addToGame: ->
#    g.addGameObject @

#  removeFromGame: ->
#    g.removeGameObject @

  loadImage: (path) ->
    if path != ''
      @img = pinst.loadImage(path)
    else
      console.error "No image to load"

#  add_animation: (anim) ->
#    if anim != null
#      @animation = anim
#      @animation.parent = @
#
#  remove_animation: ->
#    @animation = null

  frame: ->
    # Method to signalize, that a frame has passed
    # anything that is dependent on a frame, takes place here
#    if @animation != null
#      @animation.frame()

  hide: ->
    # Hide game object - so it's not drawn
    @hidden = true

  unhide: ->
    @hidden = false

  draw: () ->
    unless @hidden
#      x = @posx * window.tile_width
#      y = @posy * window.tile_height
#      if @animation != null
#        @animation.draw()
#      else
      # Compute square corners to output the image
      hW = Math.floor(@img.width/2)
      hH = Math.floor(@img.height/2)
      x1 = @posX - hW
      y1 = @posY - hH
      if @img != null
        @pr.image(@img, x1, y1, @img.width, @img.height)

      # Draw a player name
#      if @ instanceof Player
#        @pr.textFont(@font, 10)
#        @pr.text(@number, x + 12, y)



# Extension to simple object - this can move
@MovableGameObject = class _MovableGameObject extends @GameObject
  randomMove: ->
    if @polygon
      n = @polygon.getNeighbors()
      if n.length > 0
        ind = Math.floor(Math.random()*n.length)
        @setPos n[ind]

#  move: (x, y) ->
#    # Move in positive or negative direction
#    map = g.get_map()
#    nposx = @posx
#    nposy = @posy
#
#    if x > 0
#      nposx += 1
#    else if x < 0
#      nposx -= 1
#
#    if y > 0
#      nposy += 1
#    else if y < 0
#      nposy -= 1
#
#    if map.is_tile_walkable nposx, nposy
#      if map.can_get_there @posx, @posy, nposx, nposy
#        map.move_game_object @, @posx, @posy, nposx, nposy
#        @posx = nposx
#        @posy = nposy
