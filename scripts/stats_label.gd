extends Label

func show_stats(stats):
	self.text = ""
	self.text += "Name: " + str(stats["name"]) 
	self.text += "\nAge: " + str(stats["age"])
	self.text += "\nTarget age: " + str(stats["target_age_min"]) \
			 			+ " - " + str(stats["target_age_max"])
	self.show()
