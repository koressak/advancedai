@sketchProcess = (processing) ->
    p = processing
    f = p.loadFont('Arial')
    running = true

    processing.setup = () ->
      p.size window.boardWidth, window.boardHeight
      p.background 220

    processing.draw = () ->
      g = window.g

      if not g.game_finished
        g.gameLoop()
        m = g.getMap()
        if m
          m.drawMap()
          o = g.getGameObjects()
          if o
            for obj in o
              obj.draw()
#            map = g.get_map()
#            map.draw()
#        else
#            p.textFont(f, 40)
#            map = g.get_map()
#            centerx = Math.floor((map.width*tile_width) / 2)
#            centery = Math.floor((map.height*tile_height)/2)
#            p.textAlign(p.CENTER)
#            p.text("GAME WON", centerx, centery)


    processing.keyPressed = () ->
        # player = g.get_player(0)

        # console.log p.keyCode
        # if p.keyCode == 32
        #     running = !running
        #     if running
        #         p.loop()
        #     else
        #         p.noLoop()

        # if p.key.code == p.CODED
        #     if p.keyCode == p.UP
        #         player.move(0,-1)
        #     else if p.keyCode == p.DOWN
        #         player.move(0, 1)
        #     else if p.keyCode == p.LEFT
        #         player.move(-1, 0)
        #     else if p.keyCode == p.RIGHT
        #         player.move(1, 0)




