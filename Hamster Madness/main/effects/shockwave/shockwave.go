components {
  id: "shockwave"
  component: "/main/effects/shockwave/shockwave.script"
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"shockwave_ring\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/main/effects/shockwave/shockwave.atlas\"\n"
  "}\n"
  ""
}
