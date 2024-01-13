extends Label

func write_patron_stats(stats):
	self.text = ""
	self.text += stats["name"]
	self.text += "\n" + str(stats["age"])
	self.text += "\n\n"
