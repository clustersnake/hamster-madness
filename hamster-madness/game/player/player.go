components {
  id: "player"
  component: "/game/player/player.script"
}
embedded_components {
  id: "body"
  type: "sprite"
  data: "default_animation: \"idle_down\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 392.0\n"
  "  y: 448.0\n"
  "}\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/atlases/player.atlas\"\n"
  "}\n"
  ""
}
