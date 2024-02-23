extends Node2D

@onready var gpu_particles_2d = $GPUParticles2D
@onready var sfx = $SFX

func _ready():
	sfx.volume_db = remap(Constants.SfxVolume, 0.0, 1.0, -60.0, -10.0)
	sfx.play()
	gpu_particles_2d.emitting = true

func _on_gpu_particles_2d_finished():
	queue_free()
