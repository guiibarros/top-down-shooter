class_name Utils

static func instantiate(SceneTree: PackedScene, position: Vector2, parent: Node) -> Node2D:
  var sceneInstance := SceneTree.instance() as Node2D
  sceneInstance.position = position
  parent.add_child(sceneInstance)

  return sceneInstance