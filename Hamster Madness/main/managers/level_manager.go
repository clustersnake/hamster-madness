components {
  id: "level_manager"
  component: "/main/managers/level_manager.script"
}
embedded_components {
  id: "room_small_factory"
  type: "collectionfactory"
  data: "prototype: \"/main/rooms/templates/room_small.collection\"\n"
}
embedded_components {
  id: "room_medium_factory"
  type: "collectionfactory"
  data: "prototype: \"/main/rooms/templates/room_medium.collection\"\n"
}
embedded_components {
  id: "room_large_factory"
  type: "collectionfactory"
  data: "prototype: \"/main/rooms/templates/room_large.collection\"\n"
}
embedded_components {
  id: "room_boss_factory"
  type: "collectionfactory"
  data: "prototype: \"/main/rooms/templates/room_boss.collection\"\n"
}
