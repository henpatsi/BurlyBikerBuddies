extends Label

func write_stats(stats):
	self.text = ""
	self.text += "Name: " + str(stats["name"]) 
	self.text += "\nAge: " + str(stats["age"])
	self.text += "\n\n"
	for topic in stats["likes"].keys():
		self.text += stats["likes"][topic]+ "\n"
	for topic in stats["dislikes"].keys():
		self.text += stats["dislikes"][topic] + "\n"
