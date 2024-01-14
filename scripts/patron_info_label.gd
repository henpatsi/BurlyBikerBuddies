extends RichTextLabel

func write_patron_stats(stats):
	self.text = ""
	self.text += "[b]" + str(stats["name"]) + "[/b]"
	self.text += "\n"
	self.text += "\nLikes:\n"
	for topic in stats["likes"].keys():
		self.text += topic + " "
	self.text += "\n"
	self.text += "\nDislikes:\n"
	for topic in stats["dislikes"].keys():
		self.text += topic + " "
