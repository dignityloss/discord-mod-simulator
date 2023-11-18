extends ColorRect

var index = 0
onready var vbox = $VBoxContainer
onready var anim = $AnimationPlayer

onready var points_button = $VBoxContainer/Points/Button
onready var mod_button = $VBoxContainer/Mod/Button
onready var admin_button = $VBoxContainer/Admin/Button
onready var lockdown_button = $VBoxContainer/Lockdown/Button
onready var owner_button = $VBoxContainer/Owner/Button
onready var ldhelp = $LDhelp
onready var label = $LDhelp/Label

onready var points = $VBoxContainer/Points
onready var mod = $VBoxContainer/Mod
onready var admin = $VBoxContainer/Admin
onready var lockdown = $VBoxContainer/Lockdown
onready var owners = $VBoxContainer/Owner

onready var back_button = $Button


# Called when the node enters the scene tree for the first time.
func _ready():
	
	label.visible = false
	
	points_button.connect("button_down", self, "on_points_pressed")
	mod_button.connect("button_down", self, "on_mod_pressed")
	admin_button.connect("button_down", self, "on_admin_pressed")
	owner_button.connect("button_down", self, "on_owner_pressed")
	lockdown_button.connect("button_down", self, "on_lockdown_pressed")
	back_button.connect("button_down", self, "on_back_pressed")
	ldhelp.connect("button_down", self, "on_ldhelp_pressed")
	
	
	reset()
	anim.play("in")
	
func on_back_pressed():
	label.visible = false
	anim.play("out")
	yield(get_tree().create_timer(0.5), "timeout")
	queue_free()

func on_points_pressed():
	if points.base[0] <= Globals.score:
		if Globals.upgrades[0][3] >= 10:
			Globals.upgrades[0][3] = "MAX"
			Globals.upgrades[0][0] = 0
			points_button.disabled = true
			Sfx.play_sfx(Sfx.click)
		else:
			Sfx.play_sfx(Sfx.click)
			Globals.score -= points.base[0]
			Globals.upgrades[0][0] = round(Globals.upgrades[0][0] * 1.5)
			Globals.upgrades[0][2] = true
			Globals.upgrades[0][3] += 1
			Globals.score_addition = Globals.score_addition + 10
		reset()
		
		
func on_mod_pressed():
	upgrade_role(1, mod.base, 1, mod_button)
			
func on_admin_pressed():
	upgrade_role(2, admin.base, 2, admin_button)
	
func on_owner_pressed():
	upgrade_role(4, owners.base, 3, owner_button)
	
func on_lockdown_pressed():
	if lockdown.base[0] <= Globals.score:
		if Globals.upgrades[3][3] >= 12:
			Globals.upgrades[3][3] = "MAX"
			Globals.upgrades[3][0] = 0
			Sfx.play_sfx(Sfx.click)
			lockdown_button.disabled = true
		else:
			Sfx.play_sfx(Sfx.click)
			Globals.score -= lockdown.base[0]
			Globals.upgrades[3][0] = Globals.upgrades[3][0] + 2000
			Globals.upgrades[3][2] = true
			Globals.upgrades[3][3] += 1
			Globals.lockdown_var -= 10
		reset()
		
func reset():
	index = 0
	var end_count = 0
	for i in vbox.get_children():
		i.base = Globals.upgrades[index]
		index += 1
		i.update()
		if "MAX" in i.base:
			end_count += 1
	if end_count == 5:
		Globals.end = true
		
func on_ldhelp_pressed():
	label.visible = !label.visible
		
#if anyone is seeing this please forgive me <3 i tire
func upgrade_role(index, base, status, button):
	if Globals.upgrades[index][2] != true:
		if base[0] <= Globals.score:
			Sfx.play_sfx(Sfx.click)
			Globals.score -= base[0]
			Globals.score_addition = Globals.score_addition * 3
			Globals.upgrades[index][0] = 0
			Globals.upgrades[index][2] = true
			Globals.upgrades[index][3] = "MAX"
			if Globals.status < status:
				Globals.status = status
			Globals.power += 13/3
			button.disabled = true
			reset()
