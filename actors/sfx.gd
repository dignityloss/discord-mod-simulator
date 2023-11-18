extends AudioStreamPlayer2D

onready var click = preload("res://img/click.wav")
onready var ban = preload("res://img/mixkit-explainer-video-game-alert-sweep-236.wav")
onready var explosion = preload("res://img/explosion.wav")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func play_sfx(sfx):
	stream = sfx
	playing = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
