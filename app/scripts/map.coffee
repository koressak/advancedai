# Map object

@Map = class
  init: (w, h, sitesNo) ->
    @width = w
    @height = h
    @sitesNo = sitesNo
    @landSites = []
    @waterSites = []

  generateMap: ->
    mg = new window.MapGenerator()
    mg.init(@width, @height, @sitesNo)
    mg.generateMap()
    @diagram = mg.diagram

    for cell in @diagram.cells
      if cell.biome == "water"
        @waterSites.push cell
      else if cell.biome == "land"
        @landSites.push cell


  drawMap: ->
    # Draw map to the canvas which is a global variable
    p = window.pinst

    # Draw polygons
    for cell in @diagram.cells
      if cell.biome == "water"
        p.fill(68, 68, 122)
      else if cell.biome == "land"
        p.fill(133, 170, 85)

      p.beginShape()
      for e in cell.halfedges
        p1 = e.getStartpoint()
        p2 = e.getEndpoint()
        if p1 and p2
          p.vertex(p1.x, p1.y)
          p.vertex(p2.x, p2.y)
      p.endShape()

