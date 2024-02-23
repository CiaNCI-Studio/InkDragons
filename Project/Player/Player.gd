extends CharacterBody2D
class_name Player

const ATARI_FIRE_1 = preload("res://Assets/Audio/atari_fire_1.wav")
const DAMAGE_TAKEN = preload("res://Assets/Audio/damage_taken.mp3")
const KILL_EFFECT = preload("res://Assets/Effects/KillEffect.tscn")
const PROJECTILE = preload("res://Components/Projectile.tscn") as PackedScene
const INK_TRAIL = preload("res://Player/InkTrail.tscn") as PackedScene
@onready var player_sfx = $PlayerSFX as AudioStreamPlayer2D
@onready var gun_point = $GunPoint
@onready var trail_point = $TrailPoint
@onready var flash_timer = $FlashTimer as Timer
@onready var pause = $CanvasLayer/Pause
var flashOn = true
@onready var head_sprite = $HeadSprite
@onready var hud = $CanvasLayer/Hud as HUD

const SPEED = 200.0
const ROT_SPEED = 0.3
const TRAIL_TIME = 0.2
var directions = [0.0, 90.0,  180.0,  270.0]
var currentDirection = 0
@export var lives = 4
@export var imunityTime = 3.0
@export var fireCadence = 0.5
@export var Imune : bool = false
var fireTimer = 0.0
var imunityTimer = 0.0

func _ready():
	if Imune:
		hud.visible = false	
	hud.SetLife(lives)

func _physics_process(delta):
	if fireTimer > 0.0:
		fireTimer -= delta	
	if imunityTimer > 0.0:
		imunityTimer -= delta
		FlashImunity()
	
	if Input.is_action_just_pressed("ui_cancel"):
		Pause()
		
	if Input.is_action_just_pressed("Fire"):		
		Fire()
	
	if Input.is_action_just_pressed("Right"):
		currentDirection += 1
	elif Input.is_action_just_pressed("Left"):
		currentDirection -= 1
	if currentDirection > directions.size() - 1: 
		currentDirection = 0
	if currentDirection < 0:
		currentDirection = directions.size() - 1
	rotation = lerp_angle(rotation, deg_to_rad(directions[currentDirection]), 0.5)
	velocity = transform.x * SPEED
	move_and_slide()

func Damage():
	if imunityTimer <= 0.0:
		player_sfx.stream = DAMAGE_TAKEN
		player_sfx.volume_db = remap(Constants.SfxVolume, 0.0, 1.0, -60.0, -10.0)
		player_sfx.play()
		imunityTimer = imunityTime
		FlashImunity()	
		if Imune: 
			return
		lives -= 1
		hud.SetLife(lives)
		if lives <= 0:
			var instance = KILL_EFFECT.instantiate()
			get_parent().add_child(instance)
			instance.global_position = global_position
			visible = false
			await get_tree().create_timer(3).timeout
			get_tree().change_scene_to_file("res://Stages/GameOver.tscn")
	
func FlashImunity():
	if imunityTimer > 0.0 and flash_timer.is_stopped():
		flash_timer.start()
		flash_timer.paused = false
	elif imunityTimer <= 0.0 and !flash_timer.is_stopped():
		head_sprite.visible = true
		flashOn =  true	
		flash_timer.stop()

func Fire():
	if fireTimer <= 0:
		player_sfx.stream = ATARI_FIRE_1
		player_sfx.volume_db = remap(Constants.SfxVolume, 0.0, 1.0, -60.0, -15.0)
		player_sfx.play()
		fireTimer = fireCadence
		var instance = PROJECTILE.instantiate() as Projectile
		get_parent().add_child(instance)
		instance.global_position = gun_point.global_position
		instance.global_rotation = gun_point.global_rotation
		instance.apply_impulse(velocity * 3)

func Pause():
	if Imune:
		return
	get_tree().paused = true
	pause.visible = true
	
func _on_trail_timer_timeout():
	if lives > 0:
		var instance = INK_TRAIL.instantiate() 
		get_parent().add_child(instance)
		instance.z_index = z_index - 1
		instance.global_position = trail_point.global_position
		instance.global_rotation = trail_point.global_rotation

func _on_flash_timer_timeout():
	if flashOn:
		head_sprite.visible = false
		flashOn = false
	else:
		head_sprite.visible = true
		flashOn =  true	
