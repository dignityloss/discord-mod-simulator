extends Control


var base = []
onready var amt = $Amt
onready var price = $Price

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(0.1), "timeout")
	update()
	if typeof(base[3]) != TYPE_INT:
		$Button.disabled = true

func update():
	amt.text = "x" + str(base[3])
	price.text = str(base[0]) + "p"
