components {
  id: "tutorial_floor"
  component: "/main/ui/tutorial/tutorial_floor.script"
}
embedded_components {
  id: "sprite_move"
  type: "sprite"
  data: "default_animation: \"text_move\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/main/ui/tutorial/tutorial_floor.atlas\"\n"
  "}\n"
  ""
  position {
    y: 304.0
  }
}
embedded_components {
  id: "sprite_attack"
  type: "sprite"
  data: "default_animation: \"text_attack\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/main/ui/tutorial/tutorial_floor.atlas\"\n"
  "}\n"
  ""
  position {
    x: 628.0
    y: 152.0
  }
}
embedded_components {
  id: "sprite_rescue"
  type: "sprite"
  data: "default_animation: \"text_rescue\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/main/ui/tutorial/tutorial_floor.atlas\"\n"
  "}\n"
  ""
}
