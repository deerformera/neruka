extends InteractCharacter

func activated():
	yield(Interface.chat("Curos", [
		"Mata biru cerah.. Bersinar seperti bunga",
		"Ku tak melihat adanya gelap pada matamu",
		"biarlah kupanggil Ruka",
		"Semua di sini adalah ilusi",
		"dirimu seorang sentinel, aku pun demikian",
		"kekuatan utama kita ada pada adaptasi dan belajar",
		"contohnya kau pasti sudah bertemu temanku, Rika",
		"akan kuajari tentang Rika"
	]), "completed")
	
	Utils.learn(2)
	
	yield(Interface.chat("Curos", [
		"secara cepat kau menguasai apa yang Rika mampu",
		"aku dapat mengajarimu semua yang kau ingin pelajari",
		"namun tidak sekarang. Aku sekarang hanyalah bayangan dan waktuku tidak banyak",
		"aku sekarang terperangkap di sini",
		"temui lah diriku.."
	]), "completed")
	
	yield(Interface.fade_in(), "completed")
	get_parent().queue_free()
