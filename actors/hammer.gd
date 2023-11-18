extends Area2D


onready var collision = $CollisionShape2D
var inside = false


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered", self, "on_area_entered")
	connect("area_exited", self, "on_area_exited")

func _process(delta):
	position = get_global_mouse_position()
