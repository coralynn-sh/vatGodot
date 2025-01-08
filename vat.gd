extends Node3D

@export var vatLength: float = 6

var f = 0.0
var drag: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
  var s = $Sphere.get_active_material(0)
  if f > 1.0:
    f = 0.0
  else:
    f += delta / vatLength
  s.set_shader_parameter("frame", f)


func _input(event):
  if event.is_action_pressed("click"):
    drag = true

  if event.is_action_released("click"):
    drag = false

  if event is InputEventMouseMotion and drag:
    var x = event.velocity.x
    var y = event.velocity.y
    var rot = Vector3(y, x, 0).normalized()
    var rot_amount = sqrt((x*x)+(y*y)) / 6000
    if rot.is_normalized():
      transform.basis = transform.basis.rotated(rot, rot_amount)
