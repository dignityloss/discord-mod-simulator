extends Node

var hovered_object
var score = 200

var end = false

var raid_mode = false

var lockdown_timer = 0
var lockdown_var = 120

var upgrades = { #Price, Multiplicativity, Unlocked, Amount
	0: [1000, 2, false, 0],
	1: [3000, 0, false, 0],
	2: [7000, 0, false, 0],
	3: [5000, 0, false, 0],
	4: [20000, 0, false, 0],
	5: [1000000, 0, false, 0],
}

func _process(delta):
	if lockdown_timer >= 0:
		lockdown_timer -= delta

var score_addition = 20 * (upgrades[0][3] + 1)
var ruletypes = ["nsfw", "harrassment", "language", "homophobe", "raid"] #Might make more

var status = 0

var power = (status+1) * 2

var statuses = {
	0: "Trial Mod",
	1: "Mod",
	2: "Admin",
	3: "Owner"
}
