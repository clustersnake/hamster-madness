components {
  id: "active_shield"
  component: "/main/projectile/active_shield.script"
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"ball_small_3\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/main/projectile/projectile.atlas\"\n"
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
  "group: \"projectile\"\n"
  "mask: \"default\"\n"
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
  "  data: 13.0\n"
  "}\n"
  ""
}
embedded_components {
  id: "dropped_shield_factory"
  type: "factory"
  data: "prototype: \"/main/projectile/dropped_shield.go\"\n"
  ""
}
