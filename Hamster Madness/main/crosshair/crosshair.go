components {
  id: "crosshair"
  component: "/main/crosshair/crosshair.script"
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"crosshair\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/main/crosshair/crosshair.atlas\"\n"
  "}\n"
  ""
  scale {
    x: 0.5
    y: 0.5
  }
}
