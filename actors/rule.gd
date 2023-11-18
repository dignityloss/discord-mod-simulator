extends Button


var selected_ruletype
onready var sprite = $AnimatedSprite
onready var anim = $AnimationPlayer
onready var anim2 = $AnimationPlayer2
onready var bar = $ProgressBar

var locked = false

var hp : int
var repeat = false


# Called when the node enters the scene tree for the first time.
func _ready():
	bar.max_value = hp
	connect("button_down", self, "on_button_pressed")
	selected_ruletype = pick_random_rule()
	sprite.play(selected_ruletype)
	rect_position = pick_random_loc()
	anim.play("loop")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	bar.value = hp

func on_button_pressed():
	if hp > 1:
		hp -= Globals.power
		anim.play("hit")
	else:
		restart()
		Stats.banned += 1



	
func pick_random_rule():
	var random = RandomNumberGenerator.new()
	random.randomize()
	var number = random.randi_range(0, 3)
	return Globals.ruletypes[number]
	
func pick_random_loc():
	var random = RandomNumberGenerator.new()
	random.randomize()
	var posx = random.randi_range(140, (960-140))
	random.randomize()
	var posy = random.randi_range(35, (540-35))
	return Vector2(posx, posy)
	
func restart():
	if !locked:
		Sfx.play_sfx(Sfx.ban)
	if locked:
		locked = !locked
	restart_fail()
	Stats.failed -= 1
	Globals.score += Globals.score_addition



	
func restart_fail():
	if Globals.raid_mode == false:
		var random = RandomNumberGenerator.new()
		random.randomize()
		var hp_ratio = random.randi_range(1, 4)
		hp = hp_ratio * (Globals.status + 2)
		bar.max_value = hp
		selected_ruletype = pick_random_rule()
	else:
		hp = 1
		bar.max_value = hp
		selected_ruletype = "raid"
	sprite.play(selected_ruletype)
	rect_position = pick_random_loc()
	anim.play("RESET")
	anim.play("loop")
	Stats.failed += 1
