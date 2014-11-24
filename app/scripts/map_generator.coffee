# Map generator for the AI game

@MapGenerator = class
  init: (w, h, sitesNo) ->
    @width = w
    @height = h
    @sitesNo = sitesNo
    @sites = new Array
    @diagram = null
    @voronoi = new Voronoi
    @relaxCount = 0
    @maxRelaxation = 10

  randomSites: (count) ->
    for i in [0..count]
      x = get_random_int(0, @width)
      y = get_random_int(0, @height)
      @sites.push(
        x: x
        y: y
      )

  relaxSites: () ->
    # Lloyd relaxation
    if not @diagram
      return

    cells = @diagram.cells
    iCell = cells.length
    again = false
    sites = []
    p = 1 / iCell * 0.1;

    while iCell--
      cell = cells[iCell]
      rn = Math.random()
      # probability of apoptosis
      if rn < p
        continue

      site = @cellCentroid(cell)
      dist = @distance(site, cell.site)
#      again = again || dist > 1

      # don't relax too fast
      if dist > 2
        site.x = (site.x+cell.site.x)/2
        site.y = (site.y+cell.site.y)/2

      # probability of mytosis
      if rn > (1-p)
        dist /= 2
        sites.push(
          x: site.x+(site.x-cell.site.x)/dist
          y: site.y+(site.y-cell.site.y)/dist
        )

      sites.push(site)

    @compute(sites)
    if @relaxCount++ < @maxRelaxation
      @relaxSites()


  distance: (a, b) ->
    dx = a.x - b.x
    dy = a.y - b.y
    Math.sqrt(dx*dx+dy*dy)

  cellArea: (cell) ->
    area = 0
    halfedges = cell.halfedges
    iHalfedge = halfedges.length

    while iHalfedge--
      halfedge = halfedges[iHalfedge]
      p1 = halfedge.getStartpoint()
      p2 = halfedge.getEndpoint()

      area += p1.x * p2.y
      area -= p1.y * p2.x

    area /= 2
    area

  cellCentroid: (cell) ->
    x = 0
    y = 0
    halfedges = cell.halfedges
    iHalfedge = halfedges.length

    while iHalfedge--
      halfedge = halfedges[iHalfedge]
      p1 = halfedge.getStartpoint()
      p2 = halfedge.getEndpoint()
      v = p1.x*p2.y - p2.x*p1.y
      x += (p1.x+p2.x) * v
      y += (p1.y+p2.y) * v

    v = @cellArea(cell) * 6
    res =
      x: x/v
      y: y/v

    res

  compute: (sites) ->
    @sites = sites
    @voronoi.recycle(@diagram)
    @diagram = @voronoi.compute(@sites, @bbox)

  assignBiomes: ->
    ###
    Assign biomes to the generated map
    Expecting diagram to be fully relaxed voronoi.

    Now, each polygon touching the edge will be water.
    Otherwise it will be ground
    ###
    if not @diagram
      return

    for c in @diagram.cells
      c.biome = "land"
      for he in c.halfedges
        if not he.edge.lSite or not he.edge.rSite
          console.log "Found water"
          c.biome = "water"
          break

  generateMap: ->
    @randomSites(@sitesNo)
    @bbox =
      xl: 0
      xr: @width
      yt: 0
      yb: @height
    @compute(@sites, @bbox)
    console.log @diagram
    @relaxSites()
    @assignBiomes()