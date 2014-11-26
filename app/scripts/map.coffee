# Path Node object
@Polygon = class _Polygon
  constructor: (cell) ->
    @cell = cell
    @neighbors = []
    @neighborsById = []

  getId: ->
    @cell.site.voronoiId

  getSite: ->
  @cell.site

  getCell: ->
  @cell

  getElevation: ->
    @cell.elevation

  getDistance: ->
    @cell.distance

  #####################
  # Neighbor functions
  ######################
  addNeighbor: (n) ->
    if n.getId() != @getId() and not @neighborsById[n.getId()]
      @neighbors.push(n)
      @neighborsById[n.getId()] = n

  getNeighbors: ->
    @neighbors

  getNeighbor: (id) ->
    if @neighborsById[id]
      @neighborsById[id]
    else
      null


# Map object
@Map = class _Map
  init: (w, h, sitesNo) ->
    @width = w
    @height = h
    @sitesNo = sitesNo
    @polygons = []

  generateMap: ->
    mg = new window.MapGenerator()
    mg.init(@width, @height, @sitesNo)
    mg.generateMap()
    @diagram = mg.diagram

    #######
    # Build polygons and graph neighbors
    #######

    @polygons = []
    polygonsById = []
    for cell in @diagram.cells
      if cell.biome == "land"
        c = new Polygon(cell)
        @polygons.push c
        polygonsById[c.getId()] = c

    for vc in @polygons
      for nId in vc.getCell().getNeighborIds()
        if polygonsById[nId]
            vc.addNeighbor polygonsById[nId]



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




