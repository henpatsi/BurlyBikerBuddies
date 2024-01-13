extends Label

func show_stats(stats):
	self.text = ""
	self.text += "Name: " + str(stats["name"]) 
	self.text += "\nAge: " + str(stats["age"])
	self.show()
