extends Node

var playtime = 0
var rounded_playtime : int

var failed : int
var banned : int

func _process(delta):
	playtime += delta
	rounded_playtime = round(playtime)
