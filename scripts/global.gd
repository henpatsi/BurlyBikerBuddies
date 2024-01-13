extends Node

var money = 0
var friends = 0

func add_money(amount):
	money += amount
func set_money(amount):
	money = amount
func get_money():
	return (money)

func add_friend():
	friends += 1
func set_friends(amount):
	friends = amount
func get_friends():
	return friends
