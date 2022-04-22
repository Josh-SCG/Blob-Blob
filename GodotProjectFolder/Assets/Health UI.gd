extends Control

var hearts = 3 setget setHearts
var max_hearts = 3 setget setMaxHearts

onready var label = $Label

func setHearts(value):
	hearts = clamp(value, 0, max_hearts)

func setMaxHearts(value):
	max_hearts = max(value, 1)

func _ready():
	#self.max_hearts = PlayerStats.maxHealth
	#self.hearts = PlayerStats.heatlh
	pass
