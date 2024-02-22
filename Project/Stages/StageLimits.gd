extends Node2D
@onready var left = $Left
@onready var right = $Right
@onready var up = $Up
@onready var down = $Down
@onready var left_point = $LeftPoint
@onready var right_point = $RightPoint
@onready var up_point = $UpPoint
@onready var down_point = $DownPoint

func _ready():
	left.connect("body_entered", LeftPass)
	right.connect("body_entered", RightPass)
	up.connect("body_entered", UpPass)
	down.connect("body_entered", DownPass)

func LeftPass(body):
	body.global_position = Vector2(right_point.global_position.x, body.global_position.y)
	
func RightPass(body):
	body.global_position = Vector2(left_point.global_position.x, body.global_position.y)	
	
func UpPass(body):
	body.global_position = Vector2(body.global_position.x, down_point.global_position.y)	
	
func DownPass(body):
	body.global_position = Vector2(body.global_position.x, up_point.global_position.y)	
