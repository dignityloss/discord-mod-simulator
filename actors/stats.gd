extends ColorRect

onready var anim = $AnimationPlayer
onready var stats = $Stats

var playtimes 
var playtimem
var playtimeh


onready var back_button = $Button


# Called when the node enters the scene tree for the first time.
func _ready():
	back_button.connect("button_down", self, "on_back_pressed")
	anim.play("in")
	
func _process(delta):
	stats.text = "Playtime: " + time_convert(Stats.rounded_playtime) + "\nBanned: " + str(Stats.banned) + "\nRole: " + Globals.statuses[Globals.status] + "\n\nPower: " + str(Globals.power) + "\nFailed: " + str(Stats.failed) + "\nPoints Per Ban: " + str(Globals.score_addition) + "\n\nLockdown Timer: " + str(abs(round(Globals.lockdown_timer))) + "s"
	
func time_convert(time_in_sec):
	var seconds = time_in_sec%60
	var minutes = (time_in_sec/60)%60
	var hours = (time_in_sec/60)/60

	#returns a string with the format "HH:MM:SS"
	return "%02d:%02d:%02d" % [hours, minutes, seconds]
	
func on_back_pressed():
	anim.play("out")
	yield(get_tree().create_timer(0.5), "timeout")
	queue_free()
