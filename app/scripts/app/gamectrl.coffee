controllers = angular.module('gai.controllers')

controllers.controller 'GameCtrl',
  ['$scope', '$rootScope', '$location', '$anchorScroll', ($scope, $rootScope, $location, $anchorScroll) ->
    # Base game definitions
    window.boardWidth = 800
    window.boardHeight = 600
    window.sitesNo = 250
    window.frame_step = 300 # 300 ms as a step

    # Base object arrays
    window.map = null
    window.game_objects = []


    #    window.powerup_spawn_percent = 15
    #    window.winning_score = 5
    #    window.max_players = 5
    # window.max_targets = 5

    $scope.is_game_running = false
    $scope.game_loaded = false
    #    $scope.winning_score = winning_score
    #
    #    $scope.players = null
    $scope.game_log = new Array
    #
    #
    $scope.toggleGame = () ->
      if $scope.is_game_running
        console.log "Stopping game"
        pinst.noLoop()
        $scope.is_game_running = false
        $scope.new_event "info", "Game stopped"
      else
        console.log "Starting game"
        $scope.new_event "info", "Game started"
        pinst.loop()
        $scope.game_loaded = true
        $scope.is_game_running = true
    #
    #    $scope.update_ui = () ->
    #        $scope.players = g.players
    #        $scope.$apply()
    #
    #    $scope.scroll_to = (id) ->
    #        $location.hash(id)
    #        $anchorScroll()
    #
    $scope.new_event = (status, msg) ->
      $scope.game_log.unshift
        status: status
        text: msg
    #
    #    # Init visualisation
    el = document.getElementById 'gamecanvas'
    window.pinst = new Processing(el, window.sketchProcess)

    # Initialize and run game
    window.g = new Game
    window.g.initGame($scope)

    # Stop game at the beginning
    pinst.noLoop()

  ]