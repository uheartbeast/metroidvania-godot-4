extends Node

var sounds_path = "res://music_and_sounds/"

@export var bullet : AudioStream
@export var click : AudioStream
@export var enemy_die : AudioStream
@export var explosion : AudioStream
@export var hurt : AudioStream
@export var jump : AudioStream
@export var pause : AudioStream
@export var powerup : AudioStream
@export var step : AudioStream
@export var unpause : AudioStream

@onready var sound_players = get_children()

func play(sound_stream, pitch_scale = 1.0, volume_db = 0.0):
	for sound_player in sound_players:
		if not sound_player.playing:
			sound_player.pitch_scale = pitch_scale
			sound_player.volume_db = volume_db
			sound_player.stream = sound_stream
			sound_player.play()
			return
	print("Too many sounds playing at once")
