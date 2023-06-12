extends Area2D

@export var sound_file: AudioStream
@export var sprite_img: Texture2D

func _ready():
	$Texture.texture = sprite_img
	$Sound.stream = sound_file

func _on_body_entered(body):
	$Sound.play()
