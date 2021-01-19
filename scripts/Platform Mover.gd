extends Node2D

var PLATFORM_SPEED = 700
var PLATFORM_DESPAWN_X = -500
var BG_SPEED = PLATFORM_SPEED/3


var paused = false
onready var ParBG :ParallaxBackground = owner.get_node_or_null("ParallaxBackground")

func _physics_process(_delta):
	if not paused:
		# manage existing platforms
		for i in get_children():
			i.position.x -= PLATFORM_SPEED*_delta
			if i.position.x < PLATFORM_DESPAWN_X:
				i.queue_free()
		if  ParBG != null:
			ParBG.set_scroll_offset(ParBG.get_scroll_offset()-Vector2(BG_SPEED*_delta,0))
