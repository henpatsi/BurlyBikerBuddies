extends RichTextLabel

func write_patron_stats(stats):
	self.text = ""
	self.text += "[b]" + str(stats["name"]) + "[/b]"
	self.text += "\n\n[u]Likes:[/u]\n"
	for topic in stats["likes"].keys():
		self.text += topic + " "
	self.text += "\n[u]Dislikes:[/u]\n"
	for topic in stats["dislikes"].keys():
		self.text += topic + " "
