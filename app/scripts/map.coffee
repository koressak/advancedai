# Path Node object
@Polygon = class _Polygon
  init: (cell) ->
    @site = cell.site
    @cell = cell
    @neighbors = []




# Map object
@Map = class _Map
  init: (w, h, sitesNo) ->
    @width = w
    @height = h
    @sitesNo = sitesNo
    @polygons = []
#    @idsUsed = []

  generateMap: ->
    mg = new window.MapGenerator()
    mg.init(@width, @height, @sitesNo)
    mg.generateMap()
    @diagram = mg.diagram
#    console.log @diagram

    landSites = []
    for cell in @diagram.cells
      if cell.biome == "land"
        landSites.push cell

    for vc in landSites
      node = new Polygon
      node.init(vc)
      for nId in vc.getNeighborIds()
        for nc in landSites
          if nc.site.voronoiId == nId
            node.neighbors.push nc
      @polygons.push node

#    console.log @landSites

#    @pathRoot = @buildPathGraph(null, landSites)
#    console.log @pathRoot


#  buildPathGraph: (n, landSites) ->
#    root = new PathNode
#    if not n
#      index = 0
#    else
#      index = landSites.indexOf(n)
#
#    root.init landSites[index]
#    @idsUsed.push root.site.voronoiId
#
#    for nId in root.cell.getNeighborIds()
#      for s in landSites
#        if @idsUsed.indexOf(s.site.voronoiId) == -1
#          if nId == s.site.voronoiId
#            root.neighbors.push @buildPathGraph(s, landSites)
#
#    root

  drawMap: ->
    # Draw map to the canvas which is a global variable
    p = window.pinst
    # Normalize colors
    p.stroke(0,0,0)
    p.fill(0,0,0)

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

    # Draw path graph
#    for node in @landSites
#      p.fill(0,0,0)
#      p.ellipse(node.site.x, node.site.y, 5, 5)
#      p.stroke(255,0,0)
#      for n in node.neighbors
#        s2 = n.site
#        p.line(node.site.x, node.site.y, s2.x, s2.y)




