components {
  id: "dropped_shield"
  component: "/game/objects/dropped_shield/dropped_shield.script"
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"ball_small_2\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/game/ui/atlases/shield.atlas\"\n"
  "}\n"
  ""
  scale {
    x: 0.015
    y: 0.015
  }
}
embedded_components {
  id: "collisionobject"
  type: "collisionobject"
  data: "type: COLLISION_OBJECT_TYPE_TRIGGER\n"
  "mass: 0.0\n"
  "friction: 0.1\n"
  "restitution: 0.5\n"
  "group: \"dropped_shield\"\n"
  "mask: \"player\"\n"
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
  "  data: 0.6\n"
  "}\n"
  ""
}
