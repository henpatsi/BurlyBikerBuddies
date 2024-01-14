extends RichTextLabel

func write_stats(stats):
	self.text = ""
	self.text += "[b]" + str(stats["name"]) + "[/b]"
	self.text += "\n\n"
	for topic in stats["likes"].keys():
		self.text += stats["likes"][topic]+ "\n"
	self.text += "\n"
	for topic in stats["dislikes"].keys():
		self.text += stats["dislikes"][topic] + "\n"
