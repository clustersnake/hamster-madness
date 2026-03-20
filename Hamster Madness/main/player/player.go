components {
  id: "player"
  component: "/main/player/player.script"
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"walk_down\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/main/player/player.atlas\"\n"
  "}\n"
  ""
}
embedded_components {
  id: "collisionobject"
  type: "collisionobject"
  data: "type: COLLISION_OBJECT_TYPE_KINEMATIC\n"
  "mass: 0.0\n"
  "friction: 0.1\n"
  "restitution: 0.5\n"
  "group: \"player\"\n"
  "mask: \"default\"\n"
  "mask: \"projectile\"\n"
  "mask: \"enemy\"\n"
  "mask: \"fallen\"\n"
  "embedded_collision_shape {\n"
  "  shapes {\n"
  "    shape_type: TYPE_SPHERE\n"
  "    position {\n"
  "    }\n"
  "    rotation {\n"
  "    }\n"
  "    index: 0\n"
  "    count: 1\n"
  "  }\n"
  "  data: 30.0\n"
  "}\n"
  ""
}
embedded_components {
  id: "projectile_factory"
  type: "factory"
  data: "prototype: \"/main/projectile/projectile.go\"\n"
  ""
}
embedded_components {
  id: "shield"
  type: "sprite"
  data: "default_animation: \"ball_large\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/main/player/player.atlas\"\n"
  "}\n"
  ""
  position {
    z: 0.1
  }
}
embedded_components {
  id: "active_shield_factory"
  type: "factory"
  data: "prototype: \"/main/projectile/active_shield.go\"\n"
  ""
}
