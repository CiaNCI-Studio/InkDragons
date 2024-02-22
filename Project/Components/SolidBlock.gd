extends StaticBody2D

func _on_area_2d_area_entered(area):
	if area.is_in_group("player_contact"):
		(area.get_parent() as Player).Damage()


func _on_area_2d_body_entered(body):
	if body.is_in_group("projectile"):
		(body as Projectile).Destroy()		
	
