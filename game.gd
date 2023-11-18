extends Node2D

onready var score_label = $CanvasLayer/RichTextLabel
onready var upgrades_button = $Upgrades
onready var stats_button = $Stats
onready var upgrades_screen = preload("res://actors/upgrades.tscn")
onready var stats_screen = preload("res://actors/stats.tscn")
onready var rule = preload("res://actors/rule.tscn")
onready var anim = $AnimationPlayer
onready var anim2 = $AnimationPlayer2
onready var audio = $AudioStreamPlayer
onready var raids = $Raids
onready var music = $Music

var addmod = false
var addadmin = false
var addowner = false

# Called when the node enters the scene tree for the first time.
func _ready():
	music.play(1.4)
	anim.play("in")
	upgrades_button.connect("button_down", self, "on_upgrades_pressed")
	stats_button.connect("button_down", self, "on_stats_pressed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.end == true:
		get_tree().change_scene("res://actors/end.tscn")
	if Input.is_action_just_pressed("lockdown"):
		if Globals.upgrades[3][2] == true && Globals.lockdown_timer <= 0:
			Sfx.play_sfx(Sfx.explosion)
			for i in raids.get_children():
				i.locked = true
				i.restart()
			Globals.lockdown_timer = Globals.lockdown_var
	if Globals.upgrades[1][2] == true && addmod == false:
		raids.add_child(rule.instance())
		addmod = true
	if Globals.upgrades[2][2] == true && addadmin == false:
		raids.add_child(rule.instance())
		addadmin = true
		yield(get_tree().create_timer(30), "timeout")
		raid()
	if Globals.upgrades[4][2] == true && addowner == false:
		audio.play(0.26)
		anim2.play("jumpscare")
		raids.add_child(rule.instance())
		addowner = true
		yield(get_tree().create_timer(120), "timeout")
		raid()
	score_label.text = "Server Points: \n" + str(Globals.score)
	
func on_upgrades_pressed():
	add_child(upgrades_screen.instance())

func on_stats_pressed():
	add_child(stats_screen.instance())
	
func raid():
	var index = 0
	Globals.raid_mode = true
	anim.play("raid")
	for i in 7:
		raids.add_child(rule.instance())
	yield(get_tree().create_timer(30), "timeout")
	for i in raids.get_children():
		i.queue_free()
		index += 1
		if index == 7:
			break
	anim.play("raidgone")
	Globals.raid_mode = false
