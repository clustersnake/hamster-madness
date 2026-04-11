components {
  id: "game_manager"
  component: "/main/managers/game_manager.script"
}
embedded_components {
  id: "fallen_player_factory"
  type: "factory"
  data: "prototype: \"/main/player/fallen_player.go\"\n"
  ""
}
embedded_components {
  id: "player_factory"
  type: "factory"
  data: "prototype: \"/main/player/player.go\"\n"
  ""
}
embedded_components {
  id: "ball_factory"
  type: "factory"
  data: "prototype: \"/main/projectile/dropped_shield.go\"\n"
  ""
}
embedded_components {
  id: "turtle_factory"
  type: "factory"
  data: "prototype: \"/main/enemies/bosses/turtle/turtle.go\"\n"
  ""
}
