extends Label

func write_patron_stats(stats):
	self.text = ""
	self.text += "Name: " + str(stats["name"]) 
	self.text += "\nAge: " + str(stats["age"])
	self.text += "\nLikes:\n"
	for topic in stats["likes"].keys():
		self.text += topic + " "
	self.text += "\nDislikes:\n"
	for topic in stats["dislikes"].keys():
		self.text += topic + " "
