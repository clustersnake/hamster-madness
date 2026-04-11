components {
  id: "wave_manager"
  component: "/main/managers/wave_manager.script"
}
embedded_components {
  id: "chaser_factory"
  type: "factory"
  data: "prototype: \"/main/enemies/chaser/chaser.go\"\n"
  ""
}
embedded_components {
  id: "shooter_factory"
  type: "factory"
  data: "prototype: \"/main/enemies/shooter/shooter.go\"\n"
  ""
}
