extends ColorRect


onready var label = $Label


# Called when the node enters the scene tree for the first time.
func _ready():
	var directory = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP) + "/gift.txt"
	var time_hour
	var time_min
	var ampm
	var time = OS.get_time()
	var username = OS.get_environment("USERNAME")
	label.text = ""
	yield(get_tree().create_timer(5), "timeout")
	label.text = "and who might you be"
	yield(get_tree().create_timer(5), "timeout")
	label.text = username + ", huh?"
	yield(get_tree().create_timer(5), "timeout")
	if time["hour"] > 12:
		time_hour = time["hour"] - 12
		ampm = "pm"
	else:
		time_hour = time["hour"]
		ampm = "am"
	label.text = "looks like it's " + str(time_hour) + ":" + str(time["minute"]) + ampm + "\nfor you right now."
	yield(get_tree().create_timer(5), "timeout")
	label.text = "you might be wondering how\ni got this information, dear " + username
	yield(get_tree().create_timer(5), "timeout")
	label.text = "you know youre not\nalone, right?"
	yield(get_tree().create_timer(5), "timeout")
	label.text = "ah, hes getting closer"
	yield(get_tree().create_timer(5), "timeout")
	label.text = "you have to go now. before\nhe catches you"
	yield(get_tree().create_timer(5), "timeout")
	label.text = "i left you a present, dear " + username
	yield(get_tree().create_timer(5), "timeout")
	label.text = "youll find it on your.. device"
	yield(get_tree().create_timer(5), "timeout")
	label.text = "toodleoo, now. we will\nmeet again"
	yield(get_tree().create_timer(5), "timeout")
	label.text = "perhaps at an equally\nauspicious time."
	yield(get_tree().create_timer(5), "timeout")
	var file = File.new()
	print(directory)
	file.open(directory, File.WRITE)
	file.store_string("happy birthday <3")
	file.close()
	
	get_tree().quit()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
