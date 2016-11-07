function run(msg)
        start = "`سلام!`\n`به روبات سایبر خوش آمدید!`\n`لطفا یک گزینه را انتخاب کنید!`"
	sport = {{"اطلاعات لیگ ها"},{"اخبار فوتبال"},{"نتایج آنلاین بازی ها"},{"لیگ برتر ایران"},{"منوی اصلی"}}
	iranlig = {{"دسته یک ایران"},{"لیگ فوتسال ایران"},{"آلمان"},{"اسپانیا"},{"ایتالیا"},{"انگلیس"},{"فرانسه"},{"لیگ برتر هلند"},{"لیگ برتر روسیه"},{"مقدماتی آسیا گروه A"},{"مقدماتی آسیا گروه B"}{"برگشت"}}
        fun = {{"ارسال کیبرد شیشه ای به کانال"},{"فوروارد به کانال بدون منبع"},{"ارسال هر نوع فایل با زیر نویس"},{"ارسال پست با فونت های مختلف"},{"ثبت امضا"},{"حذف امضا"},{"نمایش امضا"},{"ایجاد متن با فونت های مختلف"},{"فوروارد به کانال بدون منبع"},{"منوی اصلی"}}
        convert = {{"HTML>EXE","HTML>PHP","HTML>JS"},{"HTML>JAVA","HTML>HTA","HTML>ASPX"},{"JAR>EXE","PNG>JPG","JPG>PNG"},{"TIF>PNG","TIF>JPG","GIF>JPG"},{"GIF>PNG","DPX>JPG","DPX>PNG"},{"sticker>photo","sticker>file","file>sticker"},{"photo>sticker","photo>file","file>photo"},{"text>photo","photo>exe","video>file"},{"file>video","video>gif","gif>video"},{"audio>voice","voice>audio","text>voice"},{"text>audio","qr-code>text","qr-code>voice"},{"text>qr-code","text>barcode","text>font"},{"text>style","text>nashr","text>file"},{"text>hash-b64","hash-b64>text","منوی اصلی"}}
        fonts = {{"Arial","Comic","Dyslexic"},{"Georgia","Impact","Lucida"},{"Simsun","Tahoma","Times"},{"Trebuchet","Verdana"}}
	menu = {{"اخبار فوتبال های جهان","مدیریت کانال و زیرنویس"},{"تبدیل کننده فایل ها","چت با ادمین"},{"درباره ما"}}
------------------------------------------------------
	blocks = load_data("blocks.json")
	chats = load_data("chats.json")
	requests = load_data("requests.json")
	contact = load_data("contact.json")
	location = load_data("location.json")
	users = load_data("users.json")
	admins = load_data("admins.json")
	setting = load_data("setting.json")
	userid = tostring(msg.from.id)
        msg.text = msg.text:gsub("@"..bot.username,"")
	
	if msg.chat.id == admingp then
	elseif msg.chat.type == "channel" or msg.chat.type == "supergroup" or msg.chat.type == "group" then
		return
	end
	
	if not users[userid] then
		users[userid] = true
		save_data("users.json", users)
		send_inline(msg.from.id, start, menu)
		return send_key(msg.from.id, "`منوی اصلی:`", menu)
	end
	
	if msg.text == "/start" then
		users[userid] = true
		save_data("users.json", users)
		send_inline(msg.from.id, start, menu)
		return send_key(msg.from.id, "`منوی اصلی:`", menu)
	elseif msg.contact then
		if chats.id == msg.from.id then
		else
			if contact[userid] then
				if contact[userid][msg.contact.phone_number] then
					return send_msg(msg.from.id, "`شما قبلا این شماره را ارسال کرده اید`", true)
				else
					if #contact[userid] > 10 then
						return send_msg(msg.from.id, "`دیگر نمیتوانید شماره ای ارسال کنید!`", true)
					end
					table.insert(contact[userid], msg.contact.phone_number)
					save_data("contact.json", contact)
					send_msg(msg.from.id, "`شماره شما ارسال شد`", true)
					send_msg(admingp, (msg.from.first_name or "").." "..(msg.from.last_name or "").." [@"..(msg.from.username or "-----").."] ("..msg.from.id..")", false)
					return send_fwrd(admingp, msg.from.id, msg.message_id)
				end
			else
				contact[userid] = {}
				table.insert(contact[userid], msg.contact.phone_number)
				save_data("contact.json", contact)
				send_msg(msg.from.id, "`شماره شما ارسال شد`", true)
				send_msg(admingp, (msg.from.first_name or "").." "..(msg.from.last_name or "").." [@"..(msg.from.username or "-----").."] ("..msg.from.id..")", false)
				return send_fwrd(admingp, msg.from.id, msg.message_id)
			end
		end
	elseif msg.location then
		if chats.id == msg.from.id then
		else
			if location[userid] then
				if location[userid][msg.location.longitude] then
					return send_msg(msg.from.id, "`شما قبلا این موقعیت مکانی را ارسال کرده اید`", true)
				else
					if #location[userid] > 10 then
						return send_msg(msg.from.id, "`دیگر نمیتوانید موقعیت مکانی ارسال کنید!`", true)
					end
					table.insert(location[userid], msg.location.longitude)
					save_data("location.json", location)
					send_msg(msg.from.id, "`موقعیت مکانی شما ارسال شد`", true)
					send_msg(admingp, (msg.from.first_name or "").." "..(msg.from.last_name or "").." [@"..(msg.from.username or "-----").."] ("..msg.from.id..")", false)
					return send_fwrd(admingp, msg.from.id, msg.message_id)
				end
			else
				location[userid] = {}
				table.insert(location[userid], msg.location.longitude)
				save_data("location.json", location)
				send_msg(msg.from.id, "`موقعیت مکانی شما ارسال شد`", true)
				send_msg(admingp, (msg.from.first_name or "").." "..(msg.from.last_name or "").." [@"..(msg.from.username or "-----").."] ("..msg.from.id..")", false)
				return send_fwrd(admingp, msg.from.id, msg.message_id)
			end
		end
	elseif msg.text:find("/spam") and msg.chat.id == admingp then
		local target = msg.text:input()
		if target then
			local target = target:split(",")
			if #target == 3 then
				send_msg(admingp, "`شخص مورد نظر در حال اسپم خوردن است`", true)
				for i=1,tonumber(target[2]) do
					send_msg(tonumber(target[1]), target[3])
				end
				return send_msg(admingp, "`اسپم به اتمام رسید`", true)
			elseif #target == 2 then
				send_msg(admingp, "`شخص مورد نظر در حال اسپم خوردن است`", true)
				for i=1,tonumber(target[2]) do
					send_msg(tonumber(target[1]), "سایبر\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nسایبر")
				end
				return send_msg(admingp, "`اسپم به اتمام رسید`\n_Spamming_ *Stoped*", true)
			else
				send_msg(admingp, "`شخص مورد نظر در حال اسپم خوردن است`\n_Your target_ *Spamming*", true)
				for i=1,100 do
					send_msg(tonumber(target[1]), "سایبر\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nسایبر")
				end
				return send_msg(admingp, "`اسپم به اتمام رسید`", true)
			end
		else
			return send_msg(admingp, "`بعد از این دستور آی دی شخص مورد نظر را با درج یک فاصله وارد کنید`", true)
		end
	elseif msg.text:find("/bc") and msg.chat.id == admingp then
		local usertarget = msg.text:input()
		if usertarget then
			i=0
			for k,v in pairs(users) do
				i=i+1
				send_key(tonumber(k), usertarget, keyboard)
			end
			return send_msg(admingp, "`پیام شما به "..i.." نفر ارسال شد`", true)
		else
			return send_msg(admingp, "`بعد از این دستور پیام خود را وارد کنید`", true)
		end
	elseif msg.text == "/contact" or msg.text:lower() == "my contact" or msg.text == "شماره من" then
		return send_phone(msg.from.id, "+"..sudo_num, sudo_name)
	elseif msg.text == "/users" and msg.chat.id == admingp then
		local list = ""
		i=0
		for k,v in pairs(users) do
			i=i+1
			list = list..i.."- *"..k.."*\n"
		end
		return send_msg(admingp, "*Users list:\n\n*"..list, true)
	elseif msg.text == "/blocklist" and msg.chat.id == admingp then
		local list = ""
		i=0
		for k,v in pairs(blocks) do
			if v then
				i=i+1
				list = list..i.."- *"..k.."*\n"
			end
		end
		return send_msg(admingp, "*Block list:\n\n*"..list, true)
	elseif msg.text == "/friends" and msg.chat.id == admingp then
		local list = ""
		i=0
		for k,v in pairs(admins) do
			if v then
				i=i+1
				list = list..i.."- *"..k.."*\n"
			end
		end
		return send_msg(admingp, "*Friends list:\n\n*"..list, true)
	elseif msg.text == "/req" or msg.text:lower() == "chat request" or msg.text == "ارسال درخواست چت" then
		if msg.chat.id == admingp then
			local list = ""
			i=0
			for k,v in pairs(requests) do
				if v then
					i=i+1
					list = list..i.."- *"..k.."*\n"
				end
			end
			return send_msg(admingp, "*Request list:\n\n*"..list, true)
		else
			if requests[userid] then
				return send_msg(msg.from.id, "`شما قبلا درخواست ارسال کردید، منتظر باشید رسیدگی شود`", true)
			elseif msg.from.id == chats.id then
				return send_msg(msg.from.id, "`!!پیام شما ارسال شد!!`", true)
			else
				requests[userid] = true
				save_data("requests.json", requests)
				send_msg(msg.from.id, "`درخواست شما ارسال شد، منتظر بمانید`", true)
				local text = "شما از مشخصات زیر درخواست چت دارید:\n\n"
				.."نام: "..(msg.from.first_name or "").." "..(msg.from.last_name or "").."\nیوزرنیم: @"..(msg.from.username or "-----").."\nآیدی: "..msg.from.id.."\n\n"
				--.."برای پزیرش گزینه ی اول را ارسال کنید، برای رد گزینه ی دوم را و برای بلاک کردن گزینه ی سوم را:\nfor accept press first option or for delete request press option 2 and for block user, press option 3:\n\n"
				.."1- /chat"..msg.from.id.."\n\n2- /del"..msg.from.id.."\n\n3- /block"..msg.from.id
				if not msg.from.username then
					send_fwrd(admingp, msg.from.id, msg.message_id)
				end
				return send_msg(admingp, text, false)
			end
		end
	elseif msg.text == '/sms' or msg.text:lower() == "send sms" or msg.text == "ارسال پیامک به من" then
		if admins[userid] then
			if msg.reply_to_message then
				if msg.reply_to_message.from.id == bot.id then
					return send_msg(msg.from.id, "`این دستور یا دستور /sms را با یک پیام متنی ریپلی کنید`", true)
				end
				if msg.reply_to_message.text == false or msg.reply_to_message.text == nil or msg.reply_to_message.text == "" or msg.reply_to_message.text == " " then
					return send_msg(admingp, "`فقط قادر به ارسال پیام متنی میباشید.`", true)
				end
				if string.len (msg.reply_to_message.text) > 150 then
					return send_msg(msg.from.id, "`این دستور یا دستور /sms را با یک پیام متنی ریپلی کنید`", true)
				end
				send_sms("00"..sudo_num, "[@"..(msg.from.username or "-----").."] ("..msg.from.id..")\n\n"..msg.reply_to_message.text)
				return send_msg(msg.from.id, "`پیام شما ارسال شد، از ارسال مجدد خودداری کنید`", true)
			else
				return send_msg(msg.from.id, "`این دستور یا دستور /sms را با یک پیام متنی ریپلی کنید`", true)
			end
		else
			return send_msg(msg.from.id, "`شما از دوستان نیستید و امکان استفاده از این سرویس را ندارید`", true)
		end
	elseif msg.text == "اخبار فوتبال" and msg.chat.id == admingp then
		adminkey = "
		return send_key(msg.from.id, "`از دکمه های زیر استفاده کنید`", sport, true)
	elseif msg.text:find("/info") or msg.text:lower() == "my info" or msg.text == "بیوگرافی من" then
		if msg.chat.id == admingp then
			local usertarget = msg.text:input()
			if usertarget then
				local file = io.open("./about.txt", "w")
				file:write(usertarget)
				file:flush()
				file:close() 
				return send_msg(admingp, "`مطلب مورد نظر درباره ی شما ذخیره شد`", true)
			else
				return send_msg(admingp, "`بعد از این دستور مطالب مورد نظر راجبه خود را وارد کنید`", true)
			end
		else
			local f = io.open("./about.txt")
			if f then
				s = f:read('*all')
				f:close()
				infotxts = "`بیوگرافی:`\n"..s.."\n\n"
			else
				infotxts = ""
			end
			bioinfo = infotxts.."*نام:* "..sudo_name.."\n*یوزرنیم:* [@"..sudo_user.."](https://telegram.me/"..sudo_user..")\n*شماره تلفن:* +"..sudo_num.."\n*آیدی تلگرام:* "..sudo_id.."\n*کانال:* [@"..sudo_ch.."](https://telegram.me/"..sudo_ch..
			send_msg(msg.chat.id, bioinfo, true)
		end
	elseif msg.text:find('/block') and msg.chat.id == admingp then
		local usertarget = msg.text:input()
		if usertarget then
			if tonumber(usertarget) == sudo_id or tonumber(usertarget) == bot.id then
				return send_msg(admingp, "`نمیتوانید خودتان را بلاک کنید`", true)
			end
			if blocks[tostring(usertarget)] then
				return send_msg(admingp, "`شخص مورد نظر بلاک است`", true)
			end
			blocks[tostring(usertarget)] = true
			save_data("blocks.json", blocks)
			send_msg(tonumber(usertarget), "`شما بلاک شدید!`", true)
			send_msg(admingp, "`شخص مورد نظر بلاک شد`", true)
			if requests[tostring(usertarget)] then
				requests[tostring(usertarget)] = false
				save_data("requests.json", requests)
				send_msg(tonumber(usertarget), "`درخواست چت شما رد شد`", true)
				send_msg(admingp, "`درخواست چت شخص مورد نظر رد شد`", true)
			elseif chats.id == tonumber(usertarget) then
				chats.id = 0
				save_data("chats.json", chats)
				send_msg(tonumber(usertarget), "`چت بسته شد`", true)
				send_msg(admingp, "`چت بسته شد`", true)
			end
			return
		else
			if chats.id > 0 then
				blocks[tostring(chats.id)] = true
				save_data("blocks.json", blocks)
				send_msg(chats.id, "`شما بلاک شدید!`", true)
				send_msg(admingp, "`شخص مورد نظر بلاک شد`", true)
				chats.id = 0
				save_data("chats.json", chats)
				send_msg(chats.id, "`چت بسته شد`", true)
				return send_msg(admingp, "`چت بسته شد`", true)
			else
				if msg.text == "/block" then
					return send_msg(admingp, "`بعد از این دستور آی دی شخص مورد نظر را با درج یک فاصله وارد کنید`", true)
				else
					local usertarget = msg.text:gsub("/block","")
					if tonumber(usertarget) == sudo_id or tonumber(usertarget) == bot.id then
						return send_msg(admingp, "`نمیتوانید خودتان را بلاک کنید`", true)
					end
					if blocks[tostring(usertarget)] then
						return send_msg(admingp, "`شخص مورد نظر بلاک است`", true)
					end
					blocks[tostring(usertarget)] = true
					save_data("blocks.json", blocks)
					send_msg(tonumber(usertarget), "`شما بلاک شدید!`", true)
					send_msg(admingp, "`شخص مورد نظر بلاک شد`", true)
					if requests[tostring(usertarget)] then
						requests[tostring(usertarget)] = false
						save_data("requests.json", requests)
						send_msg(tonumber(usertarget), "`درخواست چت شما رد شد`", true)
						send_msg(admingp, "`درخواست چت شخص مورد نظر رد شد`", true)
					elseif chats.id == tonumber(usertarget) then
						chats.id = 0
						save_data("chats.json", chats)
						send_msg(tonumber(usertarget), "`چت بسته شد`", true)
						send_msg(admingp, "`چت بسته شد`", true)
					end
					return
				end
			end
		end
	elseif msg.text:find('/unblock') and msg.chat.id == admingp then
		local usertarget = msg.text:input()
		if usertarget then
			if blocks[tostring(usertarget)] then
				blocks[tostring(usertarget)] = false
				save_data("blocks.json", blocks)
				send_msg(tonumber(usertarget), "`شما آنبلاک شدید!`", true)
				return send_msg(admingp, "`شخص مورد نظر آنبلاک شد`", true)
			end
			return send_msg(admingp, "`شخص مورد نظر بلاک نیست`", true)
		else
			return send_msg(admingp, "`بعد از این دستور آی دی شخص مورد نظر را با درج یک فاصله وارد کنید`", true)
		end
	elseif msg.text:find('/del') and msg.chat.id == admingp then
		local usertarget = msg.text:input()
		if usertarget then
			if requests[tostring(usertarget)] then
				requests[tostring(usertarget)] = false
				save_data("requests.json", requests)
				send_msg(tonumber(usertarget), "`درخواست چت شما رد شد`", true)
				return send_msg(admingp, "`درخواست چت شخص مورد نظر رد شد`", true)
			else
				return send_msg(admingp, "`درخواستی از شخص مورد نظر وجود ندارد`", true)
			end
		else
			if msg.text == "/del" then
				return send_msg(admingp, "`بعد از این دستور آی دی شخص مورد نظر را با درج یک فاصله وارد کنید`", true)
			else
				local usertarget = msg.text:gsub("/del","")
				if requests[tostring(usertarget)] then
					requests[tostring(usertarget)] = false
					save_data("requests.json", requests)
					send_msg(tonumber(usertarget), "`درخواست چت شما رد شد`", true)
					return send_msg(admingp, "`درخواست چت شخص مورد نظر رد شد`", true)
				else
					return send_msg(admingp, "`درخواستی از شخص مورد نظر وجود ندارد`", true)
				end
			end
		end
	elseif msg.text:find('/chat') and msg.chat.id == admingp then
		if chats.id > 0 then
			return send_msg(admingp, "`شما چت باز دارید، اول آن را ببندید`", true)
		end
		local usertarget = msg.text:input()
		if usertarget then
			if blocks[tostring(usertarget)] then
				return send_msg(admingp, "`شخص مورد نظر بلاک است`", true)
			end
			requests[tostring(usertarget)] = false
			save_data("requests.json", requests)
			chats.id = tonumber(usertarget)
			save_data("chats.json", chats)
			send_msg(tonumber(usertarget), "`چت آغاز شد، میتوانید گپ زدن را شروع کنید`", true)
			return send_msg(admingp, "`چت آغاز شد`", true)
		else
			if msg.text == "/chat" then
				return send_msg(admingp, "`بعد از این دستور آی دی شخص مورد نظر را با درج یک فاصله وارد کنید`", true)
			else
				local usertarget = msg.text:gsub("/chat","")
				if blocks[tostring(usertarget)] then
					return send_msg(admingp, "`شخص مورد نظر بلاک است`", true)
				end
				requests[tostring(usertarget)] = false
				save_data("requests.json", requests)
				chats.id = tonumber(usertarget)
				save_data("chats.json", chats)
				send_msg(tonumber(usertarget), "`چت آغاز شد، میتوانید گپ زدن را شروع کنید`", true)
				return send_msg(admingp, "`چت آغاز شد`", true)
			end
		end
	elseif msg.text == "/end" and msg.chat.id == admingp then
		if chats.id == 0 then
			return send_msg(admingp, "`چت باز موجود نیست`", true)
		end
		send_msg(admingp, "`چت با "..chats.id.." بسته شد`", true)
		send_msg(chats.id, "`چت بسته شد`", true)
		chats.id = 0
		save_data("chats.json", chats)
		return
	elseif msg.text == "/help" or msg.text:lower() == "help" or msg.text == "راهنما" then
		if msg.chat.id == admingp then
			return send_msg(admingp, help_sudo, true)
		else
			return send_inline(msg.chat.id, about_txt, about_key)
		end
	elseif msg.text == "/about" or msg.text:lower() == "about v"..bot_version or msg.text == "ربات نسخه"..bot_version then
		return send_inline(msg.chat.id, about_txt, about_key)
	end
---------------------------------------------------------------------------------------------------------------------------------------------------
	if msg.chat.id == admingp and chats.id > 0 then
		return send_fwrd(chats.id, msg.chat.id, msg.message_id)
	elseif msg.chat.id == admingp and chats.id == 0 then
		return send_msg(admingp, "`چت باز موجود نیست`", true)
	end
	if msg.from.id == chats.id then
		return send_fwrd(admingp, msg.from.id, msg.message_id)
	else
		if requests[tostring(msg.from.id)] then
			return send_msg(msg.from.id, "`منتظر بمانید تا درخواست چت شما تایید شود`", true)
		else
			return send_msg(msg.from.id, "`اول درخواست چت ارسال کنید`", true)
		end
	end
end

----------sport panel----------

	elseif msg.text == "اخبار فوتبال های جهان" then
		save_data("users.json", users)
		return send_key(msg.from.id, "`از کیبورد زیر استفاده کنید`", sport, true)
	elseif msg.text == "منوی اصلی" then
		save_data("users.json", users)
		return send_key(msg.from.id, "`منوی اصلی:`", menu, true)
	elseif msg.text == "اطلاعات لیگ ها" then
		users[userid].action = 1
		save_data("users.json", users)
		return send_key(msg.from.id, "`برای مشاهده ی اطلاعات هر لیگ، نام آن را انتخاب کنید`", iranlig, true)
	elseif msg.text == "اخبار فوتبال" then
		local res,dat = http.request('http://api.varzesh3.com/v0.2/news/live/1360000')
		if dat ~= 200 then return send_msg(msg.from.id, "`سرور خارج از سرویس میباشد لطفا بعدا تلاش کنید.`", true) end
		res = json.decode(res)
		list = "1-5 خبر آخر فوتبال"
		for i=1,5 do
			if res[i].Lead then
				if string.len(res[i].Lead) > 10 then
					newstext = ":\n<code>"..res[i].Lead.."</code>"
				else
					newstext = ""
				end
			else
				newstext = ""
			end
			dandt = res[i].LastUpdate:gsub("T","   ") --getdate(res[i].Timestamp)
			list = list.."\n<code>----------------------------------</code>\n"..i.."- <b>"..dandt.."</b>\n"..res[i].Title..newstext.."\n<a href='"..res[i].Url.."'>ادامه خبر</a>"
		end
		return send_inlines(msg.from.id, list, cbqkey)
	elseif msg.text == "نتایج آنلاین بازی ها" then
		local res,dat = http.request('http://umbrella.shayan-soft.ir/sport3/livegames.php')
		if dat ~= 200 then return send_msg(msg.from.id, "`سرور خارج از سرویس میباشد لطفا بعدا تلاش کنید.`", true) end
		res = json.decode(res)
		list = "نتایج آنلاین بازی ها\n`----------------------------------`\n"
		for i=1,#res do
			for m,n in pairs(res[i]) do
				game = ''
				for k,v in pairs(n) do
					game = game..k..' | '..v.."\n"
				end
				list = list..m..':\n`'..game..'----------------------------------`\n'
			end
		end
		return send_msg(msg.from.id, list, true)
	else
		if users[userid].action == 0 then
			return send_key(msg.from.id, "`فقط یکی از موارد کیبرد را انتخاب کنید:`", iranlig)
		end
	end
	
	if users[userid].action == 1 then
		if msg.text =="ليگ برتر ايران" then league="900931"
		elseif msg.text =="دسته يک ايران" then league="900971"
		elseif msg.text =="لیگ فوتسال ایران" then league="900977"
		elseif msg.text =="بوندسليگا - آلمان" then league="900959"
		elseif msg.text =="لالیگا - اسپانیا" then league="900958"
		elseif msg.text =="سری آ - ایتالیا" then league="900960"
		elseif msg.text =="لیگ جزیره - انگلیس" then league="900957"
		elseif msg.text =="لوشامپیون - فرانسه" then league="900961"
		elseif msg.text =="لیگ برتر هلند" then league="900962"
		elseif msg.text =="لیگ برتر روسیه" then league="900978"
		elseif msg.text =="گروه A مقدماتی آسیا" then league="900922"
		elseif msg.text =="گروه B مقدماتی آسیا" then league="900923"
		else
			return send_msg(msg.from.id, "`فقط یکی از موارد کیبرد را انتخاب کنید`", true)
		end
		local res,dat = http.request('http://api.varzesh3.com/v1.0.live/leaguestat/table/live/'..league)
		if dat ~= 200 then return send_msg(msg.from.id, "`سرور خارج از سرویس میباشد لطفا بعدا تلاش کنید.`", true) end
		res = json.decode(res)
		list = {{"برگشت","منوی اصلی"}}
		for i=1,#res do
			table.insert(list, {res[i].Team})
			x=i
		end
		users[userid].action = 2
		users[userid].teams = res
		save_data("users.json", users)
		return send_key(msg.from.id, "لیست تیمهای "..msg.text.." ("..x..")\n`برای مشاهده ی اطلاعات هر باشگاه، نام آن را انتخاب کنید`", list, true)
	elseif users[userid].action == 2 then
		if msg.text == "برگشت" then
			users[userid].action = 1
			save_data("users.json", users)
			return send_key(msg.from.id, "`برای مشاهده ی اطلاعات هر لیگ، نام آن را انتخاب کنید`", iranlig, true)
		end
		res = users[userid].teams
		for i=1,#res do
			if msg.text == res[i].Team then
				text = "`نام تیم:` "..res[i].Team.."\n\n"
					.."`امتیاز:` *"..res[i].Points.."*\n"
					.."`بازیها:` *"..res[i].Played.."*\n"
					.."نتایج:\n"
					.."`   پیروزی:` *"..res[i].Victories.."*"
					.."`   تساوی:` *"..res[i].Draws.."*"
					.."`   باخت:` *"..res[i].Defeats.."*\n"
					.."گلها:\n"
					.."`   زده:` *"..res[i].Made.."*"
					.."`   خورده:` *"..res[i].Let.."*"
					.."`   تفاضل:` *"..res[i].Diff.."*\n"
					.."[‌ ]("..res[i].FlagHQ..")" -- [@Sport3_Bot](telegram.me/Sport3_Bot)
				return send_msg(msg.from.id, text, true)
			end
		end
		return send_msg(msg.from.id, "`فقط یکی از موارد کیبرد را انتخاب کنید`", true)
	end
end

----------channel manager----------

	if msg.text:find('/add') and msg.from.id == sudo_id then
		local usertarget = msg.text:input()
		if usertarget then
			local target = usertarget:split(",")
			if users[tostring(target[1])] then
				users[tostring(target[1])].expire = tonumber(os.date("%y%m%d"))
				save_data("users.json", users)
				send_msg(target[1], "`کاربر گرامی\nحساب شما به مدت یک ماه شارژ شد`", true)
				return send_msg(sudo_id, "`کاربر مورد نظر با شناسه "..tostring(target[1]).." برای یک ماه شارژ شد`", true)
			else
				users[tostring(target[1])] = {}
				users[tostring(target[1])].expire = tonumber(os.date("%y%m%d"))
				users[tostring(target[1])].channel = target[2]
				users[tostring(target[1])].number = tostring(target[3])
				users[tostring(target[1])].action = 0
				save_data("users.json", users)
				text = "`کاربر گرامی\nعضویت در این ربات را به شما تبریک میگوییم\nکانال شما: `"..users[tostring(target[1])].channel.."\n`شماره شما: `"..users[tostring(target[1])].number
				send_key(target[1], text, keyboard, false, true)
				return send_msg(sudo_id, "`کاربر مورد نظر با شناسه "..tostring(target[1]).." افزوده شد`", true)
			end
		else
			return send_msg(sudo_id, "*/add 12345678,@CyberCH,639080363799*\n`/add [telegram id],[@channel],[number]`", true)
		end
	elseif msg.text:find('/edit') and msg.from.id == sudo_id then
		local usertarget = msg.text:input()
		if usertarget then
			local target = usertarget:split(",")
			if users[tostring(target[1])] then
				if users[tostring(target[1])].expire+100 < tonumber(os.date("%y%m%d")) then
					return send_msg(sudo_id, "`حساب کاربری کاربر مورد نظر منقضی شده است`", true)
				else
					if target[2] then
						users[tostring(target[1])].channel = target[2]
					end
					if target[3] then
						users[tostring(target[1])].number = tostring(target[3])
					end
					save_data("users.json", users)
					text = "کاربر گرامی، مشخصات شما ویرایش شد.\nکانال شما: "..users[tostring(target[1])].channel.."\nشماره شما: "..users[tostring(target[1])].number
					send_msg(target[1], text, false)
					return send_msg(sudo_id, "`کاربر مورد نظر با شناسه "..tostring(target[1]).." ویرایش شد`", true)
				end
			else
				return send_msg(sudo_id, "`کاربر مورد نظر فاقد حساب کاربری میباشد`", true)
			end
		else
			return send_msg(sudo_id, "*/edit 12345678,@CyberCH,639080363799*\n`/edit [telegram id],[@channel],[number]`", true)
		end
	chstatus = mem_info(users[userid].channel, bot.id)
	if not chstatus then
		return send_msg(msg.from.id, "`یوزرنیم کانال تغییر کرده یا کانال حذف شده است`", true)
	elseif not chstatus.ok then
		return send_msg(msg.from.id, "`یوزرنیم کانال تغییر کرده یا کانال حذف شده است`", true)
	elseif chstatus.result.status == "administrator" then
	else
		return send_msg(msg.from.id, "`برای هر عملیاتی، من را ادمین کانال قرار دهید`", true)
	end
		users[userid].action = 0
		save_data("users.json", users)
		return send_key(msg.from.id, "`کلید مورد نظر را انتخاب نمایید:`", fun)
	elseif msg.text == "ارسال پست با فونت های مختلف" then
		users[userid].action = 1
		save_data("users.json", users)
		return send_key(msg.from.id, "از این طریق میتوانید متون خود را با قابلیت مارک داون و با فونت های مختلف به کانال اضافه کنید.\n\n`برای کلفت نویسی، متن مورد نظر را بین 2 عدد * قرار دهید. دقت کنید این قابلیت مربوط به حروف انگلیسی است. مثال:\n*`Cyber`* =` *Cyber*\n\n`برای کج نویسی، متن مورد نظر را بین 2 عدد _ قرار دهید. دقت کنید این قابلیت مربوط به حروف انگلیسی است. مثال:\n_`Cyber`_ = `_Cyber_\n\n*برای ماشین نویسی یا نوستن با حالت کدینگ، متن مورد نظر را بین 2 عدد ` قرار دهید. مثال:\n`*Cyber*` = *`Cyber`*\n\n`برای لینک نویسی و هایپر لینک، متن مورد نظر را بین [] قرار دهید و لینک مورد نظر را نیز بین () بگذارید. مثال:\n[Channel](telegram.me/CyberCH)` = [Channel](telegram.me/CyberCH)\n\nمتن خود را طبق فرمول گفته شده ارسال کنید", true)
	elseif msg.text == "ارسال کیبرد شیشه ای به کانال" then
		users[userid].action = 4
		save_data("users.json", users)
		return send_key(msg.from.id, '`تیتر کیبرد اینلاین را وارد کنید. از فرمولهای مارک داون که در قسمت "ارسال پست با فونت های مختلف" توضیح داده شد نیز میتوانید استفاده کنید.`', {"مثال کیبرد اینلاین"}}, true)
	elseif msg.text == "فوروارد به کانال بدون منبع" then
		users[userid].action = 5
		save_data("users.json", users)
		if users[userid].caption then
			inkeycustm = {{"ارسال با زیرنویس اورجینال"},{"ارسال بدون زیرنویس"},{"ارسال با امضای پیشفرض"}}
		else
			inkeycustm = {{"ارسال با زیرنویس اورجینال"},{"ارسال بدون زیرنویس"}}
		end
		return send_key(msg.from.id, '`یکی از کلید ها را انتخاب کنید`', inkeycustm, true)
	elseif msg.text == "ارسال هر نوع فایل با زیر نویس" then
		users[userid].action = 3
		save_data("users.json", users)
		return send_key(msg.from.id, "`یک عکس، ویدئو، گیف، فایل یا موسیقی ارسال نمایید. حداکثر حجم مجاز 50 مگابایت میباشد.`", {{"لغو"}}, true)
	elseif msg.text == "ارسال پست زماندار" then
		if users[userid].ctime then
			users[userid].action = 6
			save_data("users.json", users)
			return send_key(msg.from.id, "هم اکنون شما یک پست زماندار دارید. زمان ارسال "..os.date("%F , %H:%M",users[userid].ctime).." میباشد و متن به شرح زیر است:\n\n"..users[userid].ctext, {{"لغو"},{"هم اکنون ارسال شود"},{"حذف این پست زماندار"}}, true, true)
		else
			users[userid].action = 7
			save_data("users.json", users)
			return send_key(msg.from.id, "`متنی که میخواهید در آینده به کانال پست نمایید ارسال کنید. دقت کنید نمیتوانید از قابلیت مارک داون استفاده نمایید.`", {{"لغو"}}, true)
		end
	elseif msg.text == "ثبت امضا" then
		users[userid].action = 2
		save_data("users.json", users)
		return send_key(msg.from.id, "`میتوانید امضایی را در این قسمت ثبت کنید که در درج نویس ها به صورت اوتوماتیک الصاق گردد. دقت کنید که طول متن کمتر از 200 کاراکتر باشد و از الگوریتم های مارک داون نمیتوانید بهره ببرید`", {{"لغو"}}, true)
	elseif msg.text == "حذف امضا" then
		users[userid].action = 0
		users[userid].caption = false
		save_data("users.json", users)
		return send_key(msg.from.id, "`امضا حذف شد`", fun)
	elseif msg.text == "اطلاعات کانال" then
		chnum = mem_num(users[userid].channel)
		chinfo = channel(users[userid].channel)
		chadmin = ch_admins(users[userid].channel)
		chadminlist = ""
		a = 0
		for i=1,#chadmin.result do
			if chadmin.result[i].status == "creator" then
				creator = "نام: "..(chadmin.result[i].user.first_name or "").." "..(chadmin.result[i].user.last_name or "").."\nیوزرنیم: @"..(chadmin.result[i].user.username or "-----").."\nآی دی: "..chadmin.result[i].user.id
			else
				a = a+1
				chadminlist = chadminlist..a.."- "..(chadmin.result[i].user.first_name or "").." "..(chadmin.result[i].user.last_name or "").." (@"..(chadmin.result[i].user.username or "-----")..") ["..chadmin.result[i].user.id.."]\n\n"
			end
		end
		text = "نام کانال: "..chinfo.result.title.."\n\nیوزرنیم کانال: @"..(chinfo.result.username or "-----").."\n\nآی دی کانال: "..chinfo.result.id.."\n\nشماره ارتباطی با سامانه پیامکی: "..users[userid].number .."\n\nانقضای اکانت: "..users[userid].expire.."\n\nآمار کانال: "..chnum.result.."\n\nسازنده ی کانال:\n"..creator.."\n\nتعداد ادمینهای کانال: "..tostring(a+1).."\n\nلیست ادمینهای کانال:\n"..chadminlist
		--[For See First Post in Channel, Click Here](https://telegram.me/"..chinfo.result.username.."/1)
		return send_msg(msg.from.id, text, false)
	elseif msg.text == "نمایش امضا" then
		if users[userid].caption then
			return send_msg(msg.from.id, "`امضای شما جهت درج در درج نویسها:\n_______________________________\n`"..users[userid].caption, true)
		else
			return send_msg(msg.from.id, "`امضایی وجود ندارد`", true)
		end
	elseif msg.text == "مثال کیبرد اینلاین" then
		return send_inline(msg.from.id, "`تیتر کیبرد اینلاین با قابلیت استفاده از قابلیت مارک داون`", {{{text = "کانال تیم پلاس" , url = "http://telegram.me/PlusTM"}}})
	end
	
	if users[userid].action == 0 then
		return send_key(msg.from.id, "`ورودی صحیح نیست، یک گزینه دیگر را انتخاب کنید.`", fun)
	elseif users[userid].action == 1 then
		users[userid].action = 0
		save_data("users.json", users)
		send_msg(users[userid].channel, msg.text, true)
		return send_key(msg.from.id, "`مکتوبه ی مورد نظر مرسول گشت.\nدقت کنید چنانچه متن شما به کانال ارسال نشد، قطعا یکی از علامت های مارک داون به صورت مفرد در متن شما قرار دارد یعنی برای مثال در متن شما یک * به صورت مفرد قرار دارد. اگر از علامت * یا _ میخواهید به صورت مفرد استفاده نمایید، یا آن را هایپر لینک کنید یا به صورت کد نویس یا ماشین نویس بنویسید.`", fun)
	elseif users[userid].action == 2 then
		if string.len(msg.text) > 200 then
			return send_msg(msg.from.id, "`متن وارد شده بیش از 200 کاراکتر میباشد، متن را اصلاح نمایید`", true)
		end
		users[userid].action = 0
		users[userid].caption = msg.text
		save_data("users.json", users)
		return send_key(msg.from.id, "`امضا و کپشن مورد نظر ثبت شد`", fun)
	elseif users[userid].action == 3 then
		if msg.document then
			users[userid].file_type = "document"
			users[userid].file_id = msg.document.file_id
		elseif msg.video then
			users[userid].file_type = "video"
			users[userid].file_id = msg.video.file_id
		elseif msg.photo then
			i = #msg.photo
			users[userid].file_type = "photo"
			users[userid].file_id = msg.photo[i].file_id
		elseif msg.audio then
			users[userid].file_type = "audio"
			users[userid].file_id = msg.audio.file_id
		else
			return send_msg(msg.from.id, "`فقط قادر به ارسال عکس، ویدئو، گیف، فایل و موسیقی میباشید. حداکثر حجم مجاز 50 مگابایت میباشد.`", true)
		end
		users[userid].action = 30
		save_data("users.json", users)
		if users[userid].caption then
			inkeycustm = {{"وارد کردن زیرنویس"},{"ارسال بدون زیرنویس"},{"ارسال با امضای پیشفرض"}}
		else
			inkeycustm = {{"وارد کردن زیرنویس"},{"ارسال بدون زیرنویس"}}
		end
		return send_key(msg.from.id, "`یکی از آیتم ها را انتخاب نمایید`", inkeycustm, true)
	elseif users[userid].action == 30 then
		if msg.text == "وارد کردن زیرنویس" then
			users[userid].action = 31
			save_data("users.json", users)
			return send_key(msg.from.id, "`متن مورد نظر را وارد کنید، دقت کنید که متن وارد شده کمتر از 200 کاراکتر باشد و در آن از فرمولهای مارک داون استفده نشود.`", true)
		elseif msg.text == "ارسال بدون زیرنویس" then
			if users[userid].file_type == "document" then
				send_doc(users[userid].channel, users[userid].file_id, false)
			elseif users[userid].file_type == "video" then
				send_video(users[userid].channel, users[userid].file_id, false)
			elseif users[userid].file_type == "photo" then
				send_photo(users[userid].channel, users[userid].file_id, false)
			elseif users[userid].file_type == "audio" then
				send_audio(users[userid].channel, users[userid].file_id, "audio", "unknown")
			end
		elseif msg.text == "ارسال با امضای پیشفرض" then
			if not users[userid].caption then
				users[userid].action = 0
				save_data("users.json", users)
				return send_key(msg.from.id, "`امضا وجود ندارد`", fun)
			end
			if users[userid].file_type == "document" then
				send_doc(users[userid].channel, users[userid].file_id, users[userid].caption)
			elseif users[userid].file_type == "video" then
				send_video(users[userid].channel, users[userid].file_id, users[userid].caption)
			elseif users[userid].file_type == "photo" then
				send_photo(users[userid].channel, users[userid].file_id, users[userid].caption)
			elseif users[userid].file_type == "audio" then
				send_audio(users[userid].channel, users[userid].file_id, "audio", users[userid].caption)
			end
		else
			return send_msg(msg.from.id, "`ورودی صحیح نیست.`", true)
		end
		users[userid].action = 0
		save_data("users.json", users)
		return send_key(msg.from.id, "`عملیات مورد نظر انجام شد.`", fun)
	elseif users[userid].action == 31 then
		if string.len(msg.text) > 200 then
			return send_msg(msg.from.id, "`متن وارد شده بیش از 200 کاراکتر میباشد، متن را اصلاح نمایید`", true)
		end
		if users[userid].file_type == "document" then
			send_doc(users[userid].channel, users[userid].file_id, msg.text)
		elseif users[userid].file_type == "video" then
			send_video(users[userid].channel, users[userid].file_id, msg.text)
		elseif users[userid].file_type == "photo" then
			send_photo(users[userid].channel, users[userid].file_id, msg.text)
		elseif users[userid].file_type == "audio" then
			send_audio(users[userid].channel, users[userid].file_id, "audio", msg.text)
		end
		users[userid].action = 0
		save_data("users.json", users)
		return send_key(msg.from.id, "`عملیات مورد نظر انجام شد.`", keyboard)
	elseif users[userid].action == 4 then
		users[userid].action = 40
		users[userid].titr = msg.text
		save_data("users.json", users)
		return send_key(msg.from.id, "`تعداد کلیدهای کیبرد شیشه ای را وارد نمایید. حداکثر 9 عدد مجاز است.`", {{"لغو"}}, true)
	elseif users[userid].action == 40 then
		if tonumber(msg.text) > 9 then
			return send_msg(msg.from.id, "`تعداد کلیدهای مجاز حداکثر 9 عدد میباشد، اصلاح کنید.`", true)
		end
		users[userid].action = 41
		users[userid].tab = tonumber(msg.text)
		users[userid].tables = {}
		save_data("users.json", users)
		return send_key(msg.from.id, "`متن کلید `"..msg.text.."` را تا حداکثر 50 کاراکتر وارد نمایید.`", {{"لغو"}}, true)
	elseif users[userid].action == 41 then
		if string.len(msg.text) > 50 then
			return send_msg(msg.from.id, "`متن وارد شده بیش از 50 کاراکتر میباشد، متن را اصلاح نمایید`", true)
		end
		users[userid].action = 42
		users[userid].tabtxt = msg.text
		save_data("users.json", users)
		return send_msg(msg.from.id, "`لینکی که میخواهید این کلید نماینده ی آن باشد را وارد کنید\nمثال: https://telegram.me/PlusTM`", true)
	elseif users[userid].action == 42 then
		table.insert(users[userid].tables, {{text=users[userid].tabtxt,url=msg.text}})
		if users[userid].tab == 1 then
			send_inline(users[userid].channel, users[userid].titr, users[userid].tables)
			users[userid].action = 0
			save_data("users.json", users)
			return send_key(msg.from.id, "`کیبرد شیشه ای به کانال ارسال شد.`", fun)
		else
			users[userid].tab = users[userid].tab-1
			users[userid].action = 41
			save_data("users.json", users)
			return send_key(msg.from.id, "`متن کلید `"..users[userid].tab.."` را تا حداکثر 50 کاراکتر وارد نمایید.`", true)
		end
	elseif users[userid].action == 5 then
		if msg.text == "ارسال با زیرنویس اورجینال" then
			users[userid].action = 51
		elseif msg.text == "ارسال بدون زیرنویس" then
			users[userid].action = 52
		elseif msg.text == "ارسال با امضای پیشفرض" then
			if not users[userid].caption then
				users[userid].action = 0
				save_data("users.json", users)
				return send_key(msg.from.id, "`امضا وجود ندارد`", fun)
			end
			users[userid].action = 53
		else
			return send_msg(msg.from.id, "`ورودی صحیح نیست.`", true)
		end
		save_data("users.json", users)
		return send_key(msg.from.id, "`همینک انواع پست ها از جمله متن، عکس، ویدئو، گیف، فایل و موسیقی را به طور انبوه فوروارد کنید تا بدون منبع به کانال شما ارسال شود.`", {{"لغو"}}, true)
	elseif users[userid].action == 51 then
		if msg.document then
			send_doc(users[userid].channel, msg.document.file_id, (msg.caption or false))
		elseif msg.video then
			send_video(users[userid].channel, msg.video.file_id, (msg.caption or false))
		elseif msg.photo then
			i = #msg.photo
			send_photo(users[userid].channel, msg.photo[i].file_id, (msg.caption or false))
		elseif msg.audio then
			send_audio(users[userid].channel, msg.audio.file_id, (msg.audio.title or "audio"), (msg.audio.performer or "unknown"))
		elseif msg.text then
			send_msg(users[userid].channel, msg.text, false)
		else
			return send_msg(msg.from.id, "`ورودی صحیح نیست.`", true)
		end
		return send_msg(msg.from.id, "`به کانال ارسال شد`", true)
	elseif users[userid].action == 52 then
		if msg.document then
			send_doc(users[userid].channel, msg.document.file_id, false)
		elseif msg.video then
			send_video(users[userid].channel, msg.video.file_id, false)
		elseif msg.photo then
			i = #msg.photo
			send_photo(users[userid].channel, msg.photo[i].file_id, false)
		elseif msg.audio then
			send_audio(users[userid].channel, msg.audio.file_id, "audio", "unknown")
		elseif msg.text then
			send_msg(users[userid].channel, msg.text, false)
		else
			return send_msg(msg.from.id, "`ورودی صحیح نیست.`", true)
		end
		return send_msg(msg.from.id, "`به کانال ارسال شد`", true)
	elseif users[userid].action == 53 then
		if msg.document then
			send_doc(users[userid].channel, msg.document.file_id, users[userid].caption)
		elseif msg.video then
			send_video(users[userid].channel, msg.video.file_id, users[userid].caption)
		elseif msg.photo then
			i = #msg.photo
			send_photo(users[userid].channel, msg.photo[i].file_id, users[userid].caption)
		elseif msg.audio then
			send_audio(users[userid].channel, msg.audio.file_id, "audio", users[userid].caption)
		elseif msg.text then
			send_msg(users[userid].channel, msg.text.."\n\n"..users[userid].caption, false)
		else
			return send_msg(msg.from.id, "`ورودی صحیح نیست.`", true)
		end
		return send_msg(msg.from.id, "`به کانال ارسال شد`", true)
	elseif users[userid].action == 6 then
		if msg.text == "هم اکنون ارسال شود" then
			send_msg(users[userid].channel, users[userid].ctext, false)
			users[userid].ctime = false
			users[userid].ctext = false
			users[userid].action = 0
			save_data("users.json", users)
			return send_key(msg.from.id, "`پیام زماندار همینک به کانال ارسال شد.`", keyboard)
		elseif msg.text == "حذف این پست زماندار" then
			users[userid].ctime = false
			users[userid].ctext = false
			users[userid].action = 0
			save_data("users.json", users)
			return send_key(msg.from.id, "`پیام زماندار حذف شد.`", keyboard)
		end
	elseif users[userid].action == 7 then
		users[userid].ctext = msg.text
		users[userid].action = 71
		save_data("users.json", users)
		return send_msg(msg.from.id, "`تعداد روزها را از 0 تا 10 روز آینده وارد کنید. صفر یعنی همین امروز.`", true)
	elseif users[userid].action == 71 then
		if tonumber(msg.text) > 10 or tonumber(msg.text) < 0 then
			return send_msg(msg.from.id, "`مقدار وارد شده صحیح نیست، روزها را بین 0 تا 10 انتخاب کنید.`", true)
		end
		users[userid].cd = tonumber(msg.text)
		users[userid].action = 72
		save_data("users.json", users)
		return send_msg(msg.from.id, "`تعداد ساعت ها را بین 0 تا 23 وارد کنید. صفر یعنی همین ساعت.`", true)
	elseif users[userid].action == 72 then
		if tonumber(msg.text) > 23 or tonumber(msg.text) < 0 then
			return send_msg(msg.from.id, "`مقدار وارد شده صحیح نیست، ساعت را بین 0 تا 23 وارد کنید.`", true)
		end
		users[userid].ch = tonumber(msg.text)
		users[userid].action = 73
		save_data("users.json", users)
		return send_msg(msg.from.id, "`دقیقه را بین 1 تا 59 وارد کنید.`", true)
	elseif users[userid].action == 73 then
		if tonumber(msg.text) > 59 or tonumber(msg.text) < 1 then
			return send_msg(msg.from.id, "`مقدار وارد شده صحیح نیست، دقیقه را بین 1 تا 59 وارد نمایید.`", true)
		end
		H = tonumber(os.date("%H"))+users[userid].ch
		D = tonumber(os.date("%d"))+users[userid].cd
		M = tonumber(os.date("%M"))+tonumber(msg.text)
		B = tonumber(os.date("%m"))
		Y = tonumber(os.date("%y"))
		if M > 59 then
			M = M-60
			H = H+1
			if M > 10 then
				M = "0"..tostring(M)
			end
		end
		if H > 23 then
			H = H-24
			D = D+1
			if H > 10 then
				H = "0"..tostring(H)
			end
		end
		if D > 30 then
			D = D-30
			B = B+1
			if D > 10 then
				D = "0"..tostring(D)
			end
		end
		if B > 12 then
			B = B-12
			Y = Y+1
			if B > 10 then
				B = "0"..tostring(B)
			end
		end
		users[userid].ctime = tonumber(Y..B..D..H..M)
		users[userid].action = 0
		save_data("users.json", users)
		return send_key(msg.from.id, "`پیام زماندار ثبت شد`", fun)
	end
end

function cron()
	local users = load_data("users.json")
	local data = load_data("sms.json")
	local blocks = load_data("../blocks.json")
	for k,v in pairs(users) do
		if not blocks[k] then
			if users[k].ctime then
				if users[k].ctime < tonumber(os.date("%y%m%d%H%M")) then
					send_msg(users[k].channel, users[k].ctext, false)
					users[userid].ctime = false
					users[userid].ctext = false
					save_data("users.json", users)
					return send_msg(k, "`پست زماندار به کانال ارسال شد.`", true)
				end
			end
		end
	end

----------convertor----------

function photo_lower(msg)
	if msg.photo then
		i=#msg.photo
		file_size = msg.photo[i].file_size/1000
		if file_size > 3000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `3MB or 3000KB`", true) end
		a=0
		for v=1,i do
			a=a+1
			file_size = msg.photo[a].file_size/1000
			caption = "Resolution: "..msg.photo[a].width.."x"..msg.photo[a].height.."\nSize: "..file_size.."KB\n"..bot_user
			send_photo(msg.from.id, msg.photo[a].file_id, caption)
		end
		return back(msg)
	elseif msg.document then
		if not msg.document.file_name then return send_msg(msg.from.id, "_This file is_ *Unknown!*", true) end
		file_size = msg.document.file_size/1000
		if file_size > 3000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `3MB or 3000KB`", true) end
		if string.sub(msg.document.file_name:lower(), -3) == "jpg" or string.sub(msg.document.file_name:lower(), -3) == "png" then
			saved_file = "temp/dl"..msg.from.id.."."..string.sub(msg.document.file_name:lower(), -3)
			dl_file(saved_file, msg.document.file_id)
			converted = "temp/conv"..msg.from.id..".jpg"
			io.popen("convert "..saved_file.." -quality 50 "..converted)
			up_file(msg.from.id, converted, bot_user)
			return back(msg)
		else
			return send_msg(msg.from.id, "_You can send only_ *Photo* _files_", true)
		end
	else
		return send_msg(msg.from.id, "_You can send only_ *Photo File*", true)
	end
end

function html_conv(msg)
	if users[userid].sub == 1 then
		if msg.text == "HTML>EXE" then
			users[userid].sub = 2
			save_data("users.json", users)
			return send_key(msg.from.id, "_Send a_ *HTML* _file_\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
		elseif msg.text == "HTML>PHP" then
			users[userid].sub = 3
			save_data("users.json", users)
			return send_key(msg.from.id, "_Send a_ *HTML* _file_\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
		elseif msg.text == "HTML>JS" then
			users[userid].sub = 4
			save_data("users.json", users)
			return send_key(msg.from.id, "_Send a_ *HTML* _file_\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
		elseif msg.text == "HTML>JAVA" then
			users[userid].sub = 5
			save_data("users.json", users)
			return send_key(msg.from.id, "_Send a_ *HTML* _file_\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
		elseif msg.text == "HTML>HTA" then
			users[userid].sub = 6
			save_data("users.json", users)
			return send_key(msg.from.id, "_Send a_ *HTML* _file_\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
		elseif msg.text == "HTML>ASPX" then
			users[userid].sub = 7
			save_data("users.json", users)
			return send_key(msg.from.id, "_Send a_ *HTML* _file_\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
		else
			return send_msg(msg.from.id, "_You can only_ *choice a Key*", true)
		end
	end
	if msg.document then
		if not msg.document.file_name then return send_msg(msg.from.id, "_This file is_ *Unknown!*", true) end
		file_size = msg.document.file_size/1000
		if file_size > 1000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `1MB or 1000KB`", true) end
		if string.sub(msg.document.file_name:lower(), -3) == "htm" or string.sub(msg.document.file_name:lower(), -4) == "html" then
		else
			return send_msg(msg.from.id, "_You can send only_ *HTM* _files_", true)
		end
	else
		return send_msg(msg.from.id, "_You can send only_ *HTM* _files_", true)
	end
	
	if users[userid].sub == 2 then
		return send_msg(msg.from.id, "soon", true) -----------------------------------------------------------------------
	elseif users[userid].sub == 3 then
		char0 = '<?php\necho "'
		char3 = '\\n";\necho "'
		char4 = '";\n?>'
		char5 = '<!--\nhttp://telegram.me/UmbrellaTeam\nUmbrella Team and shayan soft Co. Group\n//-->'
		dl_file("temp/dl"..msg.from.id..".htm", msg.document.file_id)
		file = io.open("temp/dl"..msg.from.id..".htm", "r"):read("*all")
		input = file:gsub("\r", "")
		text = input:gsub("\n", char3)
		text = char0..text..char4..'\n\n'..char5
		file = io.open("temp/index.php", "w")
		file:write(text)
		file:flush()
		file:close() 
		up_file(msg.from.id, "temp/index.php", bot_user)
		return back(msg)
	elseif users[userid].sub == 4 then
		char0 = 'document.writeln("'
		char3 = '");\ndocument.writeln("'
		char4 = '");'
		char5 = '// http://telegram.me/UmbrellaTeam\n// Umbrella Team and shayan soft Co. Group'
		dl_file("temp/dl"..msg.from.id..".htm", msg.document.file_id)
		file = io.open("temp/dl"..msg.from.id..".htm", "r"):read("*all")
		input = file:gsub("\r", "")
		text = input:gsub("\n", char3)
		text = char0..text..char4..'\n\n'..char5
		file = io.open("temp/script.js", "w")
		file:write(text)
		file:flush()
		file:close() 
		up_file(msg.from.id, "temp/script.js", bot_user)
		send_msg(msg.from.id, '_For use this script file, use this command in_ *HTML* _file:_\n`<SCRIPT type=text/javascript src="script.js"></SCRIPT>`', true)
		return back(msg)
	elseif users[userid].sub == 5 then
		char0 = '<script type="text/javascript">\ndocument.writeln("'
		char3 = '");\ndocument.writeln("'
		char4 = '");\n</script>'
		char5 = '<!--\nhttp://telegram.me/UmbrellaTeam\nUmbrella Team and shayan soft Co. Group\n//-->'
		dl_file("temp/dl"..msg.from.id..".htm", msg.document.file_id)
		file = io.open("temp/dl"..msg.from.id..".htm", "r"):read("*all")
		input = file:gsub("\r", "")
		text = input:gsub("\n", char3)
		text = char0..text..char4..'\n\n'..char5
		file = io.open("temp/java.htm", "w")
		file:write(text)
		file:flush()
		file:close() 
		up_file(msg.from.id, "temp/java.htm", bot_user)
		return back(msg)
	elseif users[userid].sub == 6 then
		dl_file("temp/dl"..msg.from.id..".htm", msg.document.file_id)
		file = io.open("temp/dl"..msg.from.id..".htm", "r"):read("*all")
		text = "<!--\n	Umbrella Team & shayan soft Co. Group\n\n	Maked by Umbrella Bot\n\n	Website: www.Umbrella.shayan-soft.ir\n	Channel: telegram.me/umbrellateam\n	Admin: Engineer Shayan Ahmadi\n	(telegram.me/shayan_soft)-->\n"
		..'<SCRIPT language = "vbscript">\nOn Error Resume Next\nIf Lcase(Left(Right(window.location, 4), 2)) = ".ht" And Lcase(Left(window.location, 5)) <> "file:" Then\nMsgBox "This application must be run from your hard drive. Save it there first."\nwindow.navigate "about:blank"\nEnd If\nOn Error Goto 0\n</script><script language="vbscript">\n'
		.."'Umbrella Team\n"..[[</script><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"><script LANGUAGE="VBScript">Self.ResizeTo 800,600]]
		..[[</script><html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="x-ua-compatible" content="ie=9"><title>Umbrella Bot]]
		..[[</title><HTA:APPLICATION ID="Umbrella Bot App" APPLICATIONNAME="Umbrella Bot App" BORDER="thick" BORDERSTYLE="normal" ICON="http://umbrella.shayan-soft.ir/umbrella.ico" SHOWINTASKBAR="yes" SINGLEINSTANCE="yes" SYSMENU="yes" VERSION="1.0" INNERBORDER="no" MAXIMIZEBUTTON="]]
		..[[yes" MINIMIZEBUTTON="yes" NAVIGABLE="yes" CONTEXTMENU="yes" SELECTION="no" CAPTION="yes" WINDOWSTATE="normal" SCROLL="auto" SCROLLFLAT="yes"/><style type="text/css" media="screen">body{margin-bottom:0px;margin-left:0px;margin-right:0px;margin-top:0px;}]]
		..[[</style></head><body bgcolor="#ffffff" lang=FA><table width=100% border=0 cellSpacing=0 cellPadding=0><tr><td width="100%" height="100%" align="center" valign="middle">]]
		..file..[[</td></tr></body></html>]]
		file = io.open("temp/Application.hta", "w")
		file:write(text)
		file:flush()
		file:close() 
		up_file(msg.from.id, "temp/Application.hta", bot_user)
		return back(msg)
	elseif users[userid].sub == 7 then
		dl_file("temp/dl"..msg.from.id..".htm", msg.document.file_id)
		file = io.open("temp/dl"..msg.from.id..".htm", "r"):read("*all")
		input = file:gsub("\r", "\n")
		tab = input:split("\n")
		text = '#!/usr/bin/perl\nprint "Content-type: text/html\\n\\n";\n'
		for i=1, #tab do
			x=i-1
			text = text..'$code['..x..'] = "'..tab[i]..'";\n'
		end
		text = text..'for ($i=0;$i<scalar(@code);$i++) {print($code[$i]."\\n");}\n<!--\nhttp://telegram.me/UmbrellaTeam\nUmbrella Team and shayan soft Co. Group\n//-->'
		file = io.open("temp/index.aspx", "w")
		file:write(text)
		file:flush()
		file:close()
		up_file(msg.from.id, "temp/index.aspx", bot_user)
		return back(msg)
	end
end

function app_conv(msg)
	if users[userid].sub == 1 then
		if msg.text == "JAR>EXE" then
			users[userid].sub = 3
			save_data("users.json", users)
			return send_key(msg.from.id, "_Send a_ *JAR (Java)* _file_\n`Maximum 5MB - 5000KB`", {{"Home"}}, true)
		elseif check_match(msg.text, {"BAT>CMD","BAT>PIF","CMD>BAT","CMD>PIF","EXE>SCR","SCR>EXE"}) then
			formats = msg.text:split(">")
			users[userid].input = formats[1]
			users[userid].output = formats[2]
			users[userid].sub = 2
			save_data("users.json", users)
			return send_key(msg.from.id, "_Send a_ *"..formats[1].."* _file_\n`Maximum 5MB - 5000KB`", {{"Home"}}, true)
		else
			return send_msg(msg.from.id, "_You can only_ *choice a Key*", true)
		end
	elseif users[userid].sub == 2 then
		if msg.document then
			if not msg.document.file_name then return send_msg(msg.from.id, "_This file is_ *Unknown!*", true) end
			file_size = msg.document.file_size/1000
			if file_size > 5000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `5MB or 5000KB`", true) end
			if string.sub(msg.document.file_name:lower(), -3) == users[userid].input:lower() then
				saved_file = "temp/dl"..msg.from.id.."."..users[userid].input:lower()
				send_file(msg.from.id, msg.document.file_id, saved_file, bot_user)
				return back(msg)
			else
				return send_msg(msg.from.id, "_You can send only_ *"..users[userid].input.."* _files_", true)
			end
		else
			return send_msg(msg.from.id, "_You can send only_ *"..users[userid].input.."* _files_", true)
		end
	elseif users[userid].sub == 3 then
		return send_msg(msg.from.id, "soon", true)-----------------------------------------------------------------------
	end
end

function photo_conv(msg)
	if users[userid].sub == 1 then
		if check_match(msg.text, {"PNG>JPG","JPG>PNG","TIF>PNG","TIF>JPG","GIF>JPG","GIF>PNG","DPX>JPG","DPX>PNG"}) then
			formats = msg.text:split(">")
			users[userid].input = formats[1]
			users[userid].output = formats[2]
			users[userid].sub = 2
			save_data("users.json", users)
			return send_key(msg.from.id, "_Send a_ *"..formats[1].."* _file_\n`Maximum 2MB - 2000KB`", {{"Home"}}, true)
		else
			return send_msg(msg.from.id, "_You can only_ *choice a Key*", true)
		end
	elseif users[userid].sub == 2 then
		if msg.document then
			if not msg.document.file_name then return send_msg(msg.from.id, "_This file is_ *Unknown!*", true) end
			file_size = msg.document.file_size/1000
			if file_size > 2000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `2MB or 2000KB`", true) end
			if string.sub(msg.document.file_name:lower(), -3) == users[userid].input:lower() then
				saved_file = "temp/dl"..msg.from.id.."."..users[userid].input:lower()
				dl_file(saved_file, msg.document.file_id)
				converted = "temp/conv"..msg.from.id.."."..users[userid].output:lower()
				io.popen("convert "..saved_file.." "..converted)
				up_file(msg.from.id, converted, bot_user)
				return back(msg)
			else
				return send_msg(msg.from.id, "_You can send only_ *"..users[userid].input.."* _files_", true)
			end
		elseif msg.photo then
			i=#msg.photo
			file_size = msg.photo[i].file_size/1000
			if file_size > 2000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `2MB or 2000KB`", true) end
			saved_file = "temp/dl"..msg.from.id.."."..users[userid].output:lower()
			dl_file(saved_file, msg.photo[i].file_id)
			up_file(msg.from.id, saved_file, bot_user)
			return back(msg)
		else
			return send_msg(msg.from.id, "_You can send only_ *"..users[userid].input.."* _files_", true)
		end
	end
end

function st_pic(msg)
	if msg.sticker then
		file_size = msg.sticker.file_size/1000
		if file_size > 1000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `1MB or 1000KB`", true) end
		file_info = "_Sticker Information:_\n"
			.."*Sticker Resolution:* `"..msg.sticker.width.."x"..msg.sticker.height.."`\n"
			.."*Sticker Size:* `"..file_size.."KB`\n"
			.."*Sticker Emoji:* "..(msg.sticker.emoji or "`None`")..bot_user
		send_msg(msg.from.id, file_info, true)
		sticker_photo(msg.chat.id, msg.sticker.file_id, bot_user)
		return back(msg)
	else
		return send_msg(msg.from.id, "_You can send only_ *Sticker* _files_", true)
	end
end

function st_file(msg)
	if msg.sticker then
		file_size = msg.sticker.file_size/1000
		if file_size > 1000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `1MB or 1000KB`", true) end
		file_info = "_Sticker Information:_\n"
			.."*Sticker Resolution:* `"..msg.sticker.width.."x"..msg.sticker.height.."`\n"
			.."*Sticker Size:* `"..file_size.."KB`\n"
			.."*Sticker Emoji:* "..(msg.sticker.emoji or "`None`")..bot_user
		send_msg(msg.from.id, file_info, true)
		sticker_file(msg.chat.id, msg.sticker.file_id, bot_user)
		return back(msg)
	else
		return send_msg(msg.from.id, "_You can send only_ *Sticker* _files_", true)
	end
end

function pic_st(msg)
	if msg.photo then
		i=#msg.photo
		file_size = msg.photo[i].file_size/1000
		if file_size > 1000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `1MB or 1000KB`", true) end
		file_info = "_Photo Information:_\n"
		.."*Photo Resolution:* `"..msg.photo[i].width.."x"..msg.photo[i].height.."`\n"
		.."*Photo Size:* `"..file_size.."KB`"..bot_user
		send_msg(msg.from.id, file_info, true)
		photo_sticker(msg.chat.id, msg.photo[i].file_id)
		return back(msg)
	else
		return send_msg(msg.from.id, "_You can send only_ *Photo* _files_", true)
	end
end

function pic_file(msg)
	if msg.photo then
		i=#msg.photo
		file_size = msg.photo[i].file_size/1000
		if file_size > 1000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `1MB or 1000KB`", true) end
		file_info = "_Photo Information:_\n"
		.."*Photo Resolution:* `"..msg.photo[i].width.."x"..msg.photo[i].height.."`\n"
		.."*Photo Size:* `"..file_size.."KB`"..bot_user
		send_msg(msg.from.id, file_info, true)
		photo_file(msg.chat.id, msg.photo[i].file_id, bot_user)
		return back(msg)
	else
		return send_msg(msg.from.id, "_You can send only_ *Photo* _files_", true)
	end
end

function vid_file(msg)
	if msg.video then
		file_size = msg.video.file_size/1000
		if file_size > 5000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `5MB or 5000KB`", true) end
		file_info = "_Video Information:_\n"
		.."*Video Resolution:* `"..msg.video.width.."x"..msg.video.height.."`\n"
		.."*Video Size:* `"..file_size.."KB`\n"
		.."*Video Time:* `"..(msg.video.duration/60).."min`"..bot_user
		send_msg(msg.from.id, file_info, true)
		video_file(msg.chat.id, msg.video.file_id, bot_user)
		return back(msg)
	else
		return send_msg(msg.from.id, "_You can send only_ *Video* _files_", true)
	end
end

function vid_gif(msg)
	if msg.video then
		file_size = msg.video.file_size/1000
		if file_size > 3000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `3MB or 3000KB`", true) end
		file_info = "_Video Information:_\n"
		.."*Video Resolution:* `"..msg.video.width.."x"..msg.video.height.."`\n"
		.."*Video Size:* `"..file_size.."KB`\n"
		.."*Video Time:* `"..(msg.video.duration/60).."min`"..bot_user
		send_msg(msg.from.id, file_info, true)
		video_gif(msg.chat.id, msg.video.file_id, bot_user)
		return back(msg)
	else
		return send_msg(msg.from.id, "_You can send only_ *Video* _files_", true)
	end
end

function gif_vid(msg)
	if msg.document then
		if not msg.document.file_name then return send_msg(msg.from.id, "_This file is_ *Unknown!*", true) end
		file_size = msg.document.file_size/1000
		if file_size > 3000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `3MB or 3000KB`", true) end
		if string.sub(msg.document.file_name:lower(), -3) == "gif" or string.sub(msg.document.file_name:lower(), -3) == "mp4" then
			file_info = "_File Information:_\n"
			.."*File Size:* `"..file_size.."KB`\n"
			.."*File Name:* `"..msg.document.file_name.."`"..bot_user
			send_msg(msg.from.id, file_info, true)
			gif_video(msg.chat.id, msg.document.file_id, bot_user)
			return back(msg)
		else
			return send_msg(msg.from.id, "_You can send only_ *Gif* _files_", true)
		end
	else
		return send_msg(msg.from.id, "_You can send only_ *Gif* _files_", true)
	end
end

function aud_voi(msg)
	if msg.audio then
		file_size = msg.audio.file_size/1000
		if file_size > 3000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `3MB or 3000KB`", true) end
		file_info = "_Audio Information:_\n"
		.."*Audio Size:* `"..file_size.."KB`\n"
		.."*Audio Time:* `"..(msg.audio.duration/60).."min`"..bot_user
		send_msg(msg.from.id, file_info, true)
		audio_voice(msg.chat.id, msg.audio.file_id)
		return back(msg)
	else
		return send_msg(msg.from.id, "_You can send only_ *Audio* _files_", true)
	end
end

function voi_aud(msg)
	if msg.voice then
		file_size = msg.voice.file_size/1000
		if file_size > 3000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `3MB or 3000KB`", true) end
		file_info = "_Voice Information:_\n"
		.."*Voice Size:* `"..file_size.."KB`\n"
		.."*Voice Time:* `"..(msg.voice.duration/60).."min`"..bot_user
		send_msg(msg.from.id, file_info, true)
		voice_audio(msg.chat.id, msg.voice.file_id, bot.first_name, msg.voice.duration, bot.username)
		return back(msg)
	else
		return send_msg(msg.from.id, "_You can send only_ *Voice* _files_", true)
	end
end

function qr_reader(msg)
	if msg.photo then
		i=#msg.photo
		file_size = msg.photo[i].file_size/1000
		if file_size > 1000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `1MB or 1000KB`", true) end
		photo_file = msg.photo[i].file_id
		photo_data = https.request(send_api.."/getFile?file_id="..photo_file)
		jtab = json.decode(photo_data)
		scan = http.request("http://api.qrserver.com/v1/read-qr-code/?fileurl=https://api.telegram.org/file/bot"..bot_token.."/"..jtab.result.file_path)
		jtab = json.decode(scan)
		if jtab[1].symbol[1].data == nil or jtab[1].symbol[1].data == false then
			if jtab[1].symbol[1]["error"] == "could not find/read QR Code" then
				return send_msg(msg.from.id, "_You'r file_ *is NOT QR Code*", true)
			else
				return send_msg(msg.from.id, jtab[1].symbol[1]["error"], false)
			end
		else
			send_msg(msg.from.id, "QR Code Data:\n______________________________\n"..jtab[1].symbol[1].data.."\n______________________________\n"..bot_user, false)
			return back(msg)
		end
	else
		return send_msg(msg.from.id, "_You'r file_ *is NOT QR Code*", true)
	end
end

function qr_make(msg)
	if msg.text == nil or msg.text == false or msg.text == "" or msg.text == " " then
		return send_msg(msg.from.id, "_You can only_ *Text Message", true)
	end
	if string.len(msg.text) > 200 then
		return send_msg(msg.from.id, "*Maximum* _text characters is_ *200*", true)
	end
	photo = http.request("http://api.qrserver.com/v1/create-qr-code/?data="..url.escape(msg.text).."&size=512x512&color=000000&bgcolor=ffffff&margin=15&format=png")
	f = io.open("temp/QR.png", "w+")
	f:write(photo)
	f:close()
	local send = send_api.."/sendPhoto"
	local curl_command = 'curl "'..send..'" -F "chat_id='..msg.from.id..'" -F "photo=@temp/QR.png" -F "caption='..bot_user..'"'
	io.popen(curl_command):read("*all")
	return back(msg)
end

function qr_voi(msg)
	if msg.photo then
		i=#msg.photo
		file_size = msg.photo[i].file_size/1000
		if file_size > 1000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `1MB or 1000KB`", true) end
		photo_file = msg.photo[i].file_id
		photo_data = https.request(send_api.."/getFile?file_id="..photo_file)
		jtab = json.decode(photo_data)
		scan = http.request("http://api.qrserver.com/v1/read-qr-code/?fileurl=https://api.telegram.org/file/bot"..bot_token.."/"..jtab.result.file_path)
		jtab = json.decode(scan)
		if jtab[1].symbol[1].data == nil or jtab[1].symbol[1].data == false then
			if jtab[1].symbol[1]["error"] == "could not find/read QR Code" then
				return send_msg(msg.from.id, "_You'r file_ *is NOT QR Code*", true)
			else
				return send_msg(msg.from.id, jtab[1].symbol[1]["error"], false)
			end
		else
			i = jtab[1].symbol[1].data
			if i:find('[ا|ب|پ|ت|ث|ج|چ|ح|خ|د|ذ|ر|ز|ژ|س|ش|ص|ض|ط|ظ|ع|غ|ف|ق|ک|گ|ل|م|ن|و|ه|ی|ي|ء|أ|إ|ؤ|ة|آ|ۀ]') then
				return send_msg(msg.from.id, "_You can only use_ *English* _QR Code_", true)
			end
			data = io.popen("curl 'https://api.voicerss.org/?key=ac4bf3739b4e4838989e995deaaddb68&src="..url.escape(jtab[1].symbol[1].data).."&hl=en-us&r=-2&c=MP3&f=8khz_8bit_stereo'"):read('*all')
			f = io.open("temp/QR_tts.mp3", "w+")
			f:write(data)
			f:close()
			send_voice(msg.from.id, "temp/QR_tts.mp3")
			return back(msg)
		end
	else
		return send_msg(msg.from.id, "_You'r file_ *is NOT QR Code*", true)
	end
end

function bar_make(msg)
	if msg.text == nil or msg.text == false or msg.text == "" or msg.text == " " then
		return send_msg(msg.from.id, "_You can only_ *Text Message", true)
	end
	if string.len(msg.text) > 50 then
		return send_msg(msg.from.id, "*Maximum* _number characters is_ *50*", true)
	end
	if not string.match(msg.text, '^%d+$') then
		return send_msg(msg.from.id, "_You can only use_ *Numbers*", true)
	end
	photo = http.request("http://www.barcodes4.me/barcode/c128c/"..url.escape(msg.text)..".png?width=500&height=170&istextdrawn=1")
	f = io.open("temp/BarCode.png", "w+")
	f:write(photo)
	f:close()
	local send = send_api.."/sendPhoto"
	local curl_command = 'curl "'..send..'" -F "chat_id='..msg.from.id..'" -F "photo=@temp/BarCode.png" -F "caption='..bot_user..'"'
	io.popen(curl_command):read("*all")
	return back(msg)
end

function hash_en(msg)
	if msg.text == nil or msg.text == false or msg.text == "" or msg.text == " " then
		return send_msg(msg.from.id, "_You can only_ *Text Message", true)
	end
	if string.len(msg.text) > 200 then
		return send_msg(msg.from.id, "*Maximum* _text characters is_ *200*", true)
	end
	cmd = io.popen('echo "'..msg.text..'" | base64 -w0'):read("*all")
	send_msg(msg.from.id, cmd.."\n"..bot_user, false)
	return back(msg)
end

function hash_de(msg)
	if msg.text == nil or msg.text == false or msg.text == "" or msg.text == " " then
		return send_msg(msg.from.id, "_You can only_ *Text Message", true)
	end
	if string.len(msg.text) > 100 then
		return send_msg(msg.from.id, "*Maximum* _hash characters is_ *1000*", true)
	end
	cmd = io.popen('echo "'..msg.text..'" | base64 -d'):read("*all")
	send_msg(msg.from.id, cmd.."\n"..bot_user, false)
	return back(msg)
end

function tts_voi(msg)
	if msg.text == nil or msg.text == false or msg.text == "" or msg.text == " " then
		return send_msg(msg.from.id, "_You can only_ *Text Message", true)
	end
	i = msg.text
	if i:find('[ا|ب|پ|ت|ث|ج|چ|ح|خ|د|ذ|ر|ز|ژ|س|ش|ص|ض|ط|ظ|ع|غ|ف|ق|ک|گ|ل|م|ن|و|ه|ی|ي|ء|أ|إ|ؤ|ة|آ|ۀ]') then
		return send_msg(msg.from.id, "_You can only use_ *English* _characters_", true)
	end
	data = io.popen("curl 'https://api.voicerss.org/?key=ac4bf3739b4e4838989e995deaaddb68&src="..url.escape(msg.text).."&hl=en-us&r=-2&c=MP3&f=8khz_8bit_stereo'"):read('*all')
	f = io.open("temp/tts.mp3", "w+")
	f:write(data)
	f:close()
	send_voice(msg.from.id, "temp/tts.mp3")
	return back(msg)
end

function tts_aou(msg)
	if msg.text == nil or msg.text == false or msg.text == "" or msg.text == " " then
		return send_msg(msg.from.id, "_You can only_ *Text Message", true)
	end
	i = msg.text
	if i:find('[ا|ب|پ|ت|ث|ج|چ|ح|خ|د|ذ|ر|ز|ژ|س|ش|ص|ض|ط|ظ|ع|غ|ف|ق|ک|گ|ل|م|ن|و|ه|ی|ي|ء|أ|إ|ؤ|ة|آ|ۀ]') then
		return send_msg(msg.from.id, "_You can only use_ *English* _characters_", true)
	end
	data = io.popen("curl 'https://api.voicerss.org/?key=ac4bf3739b4e4838989e995deaaddb68&src="..url.escape(msg.text).."&hl=en-us&r=-2&c=MP3&f=48khz_16bit_stereo'"):read('*all')
	f = io.open("temp/tts.mp3", "w+")
	f:write(data)
	f:close()
	up_file(msg.from.id, "temp/tts.mp3", bot_user)
	return back(msg)
end

function file_vid(msg)
	if msg.document then
		if not msg.document.file_name then return send_msg(msg.from.id, "_This file is_ *Unknown!*", true) end
		file_size = msg.document.file_size/1000
		if file_size > 5000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `5MB or 5000KB`", true) end
		if string.sub(msg.document.file_name:lower(), -3) == "avi" or string.sub(msg.document.file_name:lower(), -3) == "3gp" or string.sub(msg.document.file_name:lower(), -3) == "mov" or string.sub(msg.document.file_name:lower(), -3) == "mp4" then
			saved_file = "temp/dl"..msg.from.id..".avi"
			dl_file(saved_file, msg.document.file_id)
			send_video(msg.from.id, saved_file, bot_user)
			return back(msg)
		else
			return send_msg(msg.from.id, "_You can send only_ *Video* _files_", true)
		end
	else
		return send_msg(msg.from.id, "_You can send only_ *Video* _files_", true)
	end
end

function file_pic(msg)
	if msg.document then
		if not msg.document.file_name then return send_msg(msg.from.id, "_This file is_ *Unknown!*", true) end
		file_size = msg.document.file_size/1000
		if file_size > 1000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `1MB or 1000KB`", true) end
		if string.sub(msg.document.file_name:lower(), -3) == "png" or string.sub(msg.document.file_name:lower(), -3) == "jpg" or string.sub(msg.document.file_name:lower(), -3) == "gif" or string.sub(msg.document.file_name:lower(), -4) == "jpeg" then
			saved_file = "temp/dl"..msg.from.id..".jpg"
			dl_file(saved_file, msg.document.file_id)
			send_pic(msg.from.id, saved_file, bot_user)
			return back(msg)
		else
			return send_msg(msg.from.id, "_You can send only_ *Photo* _files_", true)
		end
	else
		return send_msg(msg.from.id, "_You can send only_ *Photo* _files_", true)
	end
end

function file_st(msg)
	if msg.document then
		if not msg.document.file_name then return send_msg(msg.from.id, "_This file is_ *Unknown!*", true) end
		file_size = msg.document.file_size/1000
		if file_size > 1000 then return send_msg(msg.from.id, "*Maximum* _file size:_ `1MB or 1000KB`", true) end
		if string.sub(msg.document.file_name:lower(), -3) == "png" or string.sub(msg.document.file_name:lower(), -3) == "jpg" or string.sub(msg.document.file_name:lower(), -3) == "gif" or string.sub(msg.document.file_name:lower(), -4) == "jpeg" then
			saved_file = "temp/dl"..msg.from.id..".webp"
			dl_file(saved_file, msg.document.file_id)
			send_st(msg.from.id, saved_file)
			return back(msg)
		else
			return send_msg(msg.from.id, "_You can send only_ *Photo* _files_", true)
		end
	else
		return send_msg(msg.from.id, "_You can send only_ *Photo* _files_", true)
	end
end

function style(msg)
	if msg.text == nil or msg.text == false or msg.text == "" or msg.text == " " then
		return send_msg(msg.from.id, "_You can only_ *Text Message", true)
	end
	if msg.text:lower() == "markdown help" then
		text = [[*Warning*
`Don't use this characters in you'r input text: * _ ( ) [ ]` *`*
`This characters is styles commands...`
For Write Bold Word:
     `*`Umbrella`*` or <b>Umbrella</b> = *Umbrella*
	
For Write Italic Word:
     `_`Umbrella`_` or <i>Umbrella</i> = _Umbrella_
	
For Write Code Word:
     *`*Umbrella*`* or <c>Umbrella</c> = `Umbrella`
	 
For Write Hyper Link:
     `[`Umbrella`](`umbrella.shayan-soft.ir`)` or
     <a>Umbrella</au>umbrella.shayan-soft.ir</u> = [Umbrella](umbrella.shayan-soft.ir)
	 
You can use all methods in a text:
     `*`Umbrella`*`
     `_`Umbrella`_`
     *`*Umbrella*`*
     `[`Umbrella`](`umbrella.shayan-soft.ir`)`
or
     <b>Umbrella</b>
     <i>Umbrella</i>
     <c>Umbrella</c>
     <a>Umbrella</au>umbrella.shayan-soft.ir</u>
=
     *Umbrella*
     _Umbrella_
     `Umbrella`
     [Umbrella](umbrella.shayan-soft.ir)
]]
		return send_msg(msg.from.id, text, true)
	elseif msg.text:lower() == "markdown example" then
		return send_msg(msg.from.id, "Normal: Cyber\nBold: *Cyber*\nItalic: _Cyber_\nCoder: `Cyber`\nHyper Link: [PlusTeam](telegram.me/PlusTM)", true)
	else
		local text = msg.text:gsub("<b>", "*")
		local text = text:gsub("</b>", "*")
		local text = text:gsub("<i>", "_")
		local text = text:gsub("</i>", "_")
		local text = text:gsub("<c>", "`")
		local text = text:gsub("</c>", "`")
		local text = text:gsub("<a>", "[")
		local text = text:gsub("</au>", "](")
		local text = text:gsub("</u>", ")")
		send_msg(msg.from.id, text, true)
		return back(msg)
	end
end

function font(msg)
	if msg.text == nil or msg.text == false or msg.text == "" or msg.text == " " then
		return send_msg(msg.from.id, "_You can only_ *Text Message", true)
	end
	if users[userid].sub == 1 then
		if string.len(msg.text) > 30 then
			return send_msg(msg.from.id, "_You can only send_ *30 Characters*", true)
		end
		fonts_key = {{"Home"},{"1- ⓐⓑⓒⓓⓔⓕⓖⓗⓘⓙⓚⓛⓜ"},{"2- ⒜⒝⒞⒟⒠⒡⒢⒣⒤⒥⒦⒧⒨"},{"3- αвc∂єƒgнιנкℓм"},{"4- αвcdeғɢнιjĸlм"},{"5- αв¢đefgħıנκłм"},
			{"6- ąҍçժҽƒցհìʝҟӀʍղ"},{"7- คც८ძ૯Բ૭ҺɿʆқՆɱ"},{"8- αßςdεƒghïյκﾚm"},{"9- ค๒ς๔єŦɠђเןкl๓"},{"10- ﾑ乃ζÐ乇ｷǤんﾉﾌズﾚᄊ"},{"11- αβcδεŦĝhιjκlʍ"},
			{"12- ձъƈժεբցհﻨյĸlო"},{"13- Λɓ¢Ɗ£ƒɢɦĩʝҚŁɱ"},{"14- ΛБϾÐΞŦGHłJКŁM"},{"15- ɐqɔpǝɟɓɥıſʞๅɯ"},{"16- ɒdɔbɘʇϱнiįʞlм"},{"17- A̴̴B̴̴C̴̴D̴̴E̴̴F̴̴G̴̴H̴̴I̴̴J̴̴K̴̴L̴̴M̴"}}
		users[userid].texts = msg.text
		users[userid].sub = 2
		save_data("users.json", users)
		return send_key(msg.from.id, "_choice a_ *Font* _of keys_", fonts_key, true)
	elseif users[userid].sub == 2 then
		if msg.text:find('17') then
			i=17
		elseif msg.text:find('16') then
			i=16
		elseif msg.text:find('15') then
			i=15
		elseif msg.text:find('14') then
			i=14
		elseif msg.text:find('13') then
			i=13
		elseif msg.text:find('12') then
			i=12
		elseif msg.text:find('11') then
			i=11
		elseif msg.text:find('10') then
			i=10
		elseif msg.text:find('9') then
			i=9
		elseif msg.text:find('8') then
			i=8
		elseif msg.text:find('7') then
			i=7
		elseif msg.text:find('6') then
			i=6
		elseif msg.text:find('5') then
			i=5
		elseif msg.text:find('4') then
			i=4
		elseif msg.text:find('3') then
			i=3
		elseif msg.text:find('2') then
			i=2
		elseif msg.text:find('1') then
			i=1
		end
		
		font_base = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,9,8,7,6,5,4,3,2,1,.,_"
		font_hash = "z,y,x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,Z,Y,X,W,V,U,T,S,R,Q,P,O,N,M,L,K,J,I,H,G,F,E,D,C,B,A,0,1,2,3,4,5,6,7,8,9,.,_"
		fonts = {
			"ⓐ,ⓑ,ⓒ,ⓓ,ⓔ,ⓕ,ⓖ,ⓗ,ⓘ,ⓙ,ⓚ,ⓛ,ⓜ,ⓝ,ⓞ,ⓟ,ⓠ,ⓡ,ⓢ,ⓣ,ⓤ,ⓥ,ⓦ,ⓧ,ⓨ,ⓩ,ⓐ,ⓑ,ⓒ,ⓓ,ⓔ,ⓕ,ⓖ,ⓗ,ⓘ,ⓙ,ⓚ,ⓛ,ⓜ,ⓝ,ⓞ,ⓟ,ⓠ,ⓡ,ⓢ,ⓣ,ⓤ,ⓥ,ⓦ,ⓧ,ⓨ,ⓩ,⓪,➈,➇,➆,➅,➄,➃,➂,➁,➀,●,_",
			"⒜,⒝,⒞,⒟,⒠,⒡,⒢,⒣,⒤,⒥,⒦,⒧,⒨,⒩,⒪,⒫,⒬,⒭,⒮,⒯,⒰,⒱,⒲,⒳,⒴,⒵,⒜,⒝,⒞,⒟,⒠,⒡,⒢,⒣,⒤,⒥,⒦,⒧,⒨,⒩,⒪,⒫,⒬,⒭,⒮,⒯,⒰,⒱,⒲,⒳,⒴,⒵,⓪,⑼,⑻,⑺,⑹,⑸,⑷,⑶,⑵,⑴,.,_",
			"α,в,c,∂,є,ƒ,g,н,ι,נ,к,ℓ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,χ,у,z,α,в,c,∂,є,ƒ,g,н,ι,נ,к,ℓ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,χ,у,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"α,в,c,d,e,ғ,ɢ,н,ι,j,ĸ,l,м,ɴ,o,p,q,r,ѕ,т,υ,v,w,х,y,z,α,в,c,d,e,ғ,ɢ,н,ι,j,ĸ,l,м,ɴ,o,p,q,r,ѕ,т,υ,v,w,х,y,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"α,в,¢,đ,e,f,g,ħ,ı,נ,κ,ł,м,и,ø,ρ,q,я,š,т,υ,ν,ω,χ,ч,z,α,в,¢,đ,e,f,g,ħ,ı,נ,κ,ł,м,и,ø,ρ,q,я,š,т,υ,ν,ω,χ,ч,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"ą,ҍ,ç,ժ,ҽ,ƒ,ց,հ,ì,ʝ,ҟ,Ӏ,ʍ,ղ,օ,ք,զ,ɾ,ʂ,է,մ,ѵ,ա,×,վ,Հ,ą,ҍ,ç,ժ,ҽ,ƒ,ց,հ,ì,ʝ,ҟ,Ӏ,ʍ,ղ,օ,ք,զ,ɾ,ʂ,է,մ,ѵ,ա,×,վ,Հ,⊘,९,𝟠,7,Ϭ,Ƽ,५,Ӡ,ϩ,𝟙,.,_",
			"ค,ც,८,ძ,૯,Բ,૭,Һ,ɿ,ʆ,қ,Ն,ɱ,Ո,૦,ƿ,ҩ,Ր,ς,੮,υ,౮,ω,૪,ע,ઽ,ค,ც,८,ძ,૯,Բ,૭,Һ,ɿ,ʆ,қ,Ն,ɱ,Ո,૦,ƿ,ҩ,Ր,ς,੮,υ,౮,ω,૪,ע,ઽ,0,9,8,7,6,5,4,3,2,1,.,_",
			"α,ß,ς,d,ε,ƒ,g,h,ï,յ,κ,ﾚ,m,η,⊕,p,Ω,r,š,†,u,∀,ω,x,ψ,z,α,ß,ς,d,ε,ƒ,g,h,ï,յ,κ,ﾚ,m,η,⊕,p,Ω,r,š,†,u,∀,ω,x,ψ,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,ן,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,v,ฬ,x,ץ,z,ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,ן,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,v,ฬ,x,ץ,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"ﾑ,乃,ζ,Ð,乇,ｷ,Ǥ,ん,ﾉ,ﾌ,ズ,ﾚ,ᄊ,刀,Ծ,ｱ,Q,尺,ㄎ,ｲ,Ц,Џ,Щ,ﾒ,ﾘ,乙,ﾑ,乃,ζ,Ð,乇,ｷ,Ǥ,ん,ﾉ,ﾌ,ズ,ﾚ,ᄊ,刀,Ծ,ｱ,q,尺,ㄎ,ｲ,Ц,Џ,Щ,ﾒ,ﾘ,乙,ᅙ,9,8,ᆨ,6,5,4,3,ᆯ,1,.,_",
			"α,β,c,δ,ε,Ŧ,ĝ,h,ι,j,κ,l,ʍ,π,ø,ρ,φ,Ʀ,$,†,u,υ,ω,χ,ψ,z,α,β,c,δ,ε,Ŧ,ĝ,h,ι,j,κ,l,ʍ,π,ø,ρ,φ,Ʀ,$,†,u,υ,ω,χ,ψ,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"ձ,ъ,ƈ,ժ,ε,բ,ց,հ,ﻨ,յ,ĸ,l,ო,ռ,օ,թ,զ,г,ร,է,ս,ν,ա,×,ყ,২,ձ,ъ,ƈ,ժ,ε,բ,ց,հ,ﻨ,յ,ĸ,l,ო,ռ,օ,թ,զ,г,ร,է,ս,ν,ա,×,ყ,২,0,9,8,7,6,5,4,3,2,1,.,_",
			"Λ,ɓ,¢,Ɗ,£,ƒ,ɢ,ɦ,ĩ,ʝ,Қ,Ł,ɱ,ה,ø,Ṗ,Ҩ,Ŕ,Ş,Ŧ,Ū,Ɣ,ω,Ж,¥,Ẑ,Λ,ɓ,¢,Ɗ,£,ƒ,ɢ,ɦ,ĩ,ʝ,Қ,Ł,ɱ,ה,ø,Ṗ,Ҩ,Ŕ,Ş,Ŧ,Ū,Ɣ,ω,Ж,¥,Ẑ,0,9,8,7,6,5,4,3,2,1,.,_",
			"Λ,Б,Ͼ,Ð,Ξ,Ŧ,G,H,ł,J,К,Ł,M,Л,Ф,P,Ǫ,Я,S,T,U,V,Ш,Ж,Џ,Z,Λ,Б,Ͼ,Ð,Ξ,Ŧ,g,h,ł,j,К,Ł,m,Л,Ф,p,Ǫ,Я,s,t,u,v,Ш,Ж,Џ,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"ɐ,q,ɔ,p,ǝ,ɟ,ɓ,ɥ,ı,ſ,ʞ,ๅ,ɯ,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,ɐ,q,ɔ,p,ǝ,ɟ,ɓ,ɥ,ı,ſ,ʞ,ๅ,ɯ,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"ɒ,d,ɔ,b,ɘ,ʇ,ϱ,н,i,į,ʞ,l,м,и,o,q,p,я,ƨ,т,υ,v,w,x,γ,z,ɒ,d,ɔ,b,ɘ,ʇ,ϱ,н,i,į,ʞ,l,м,и,o,q,p,я,ƨ,т,υ,v,w,x,γ,z,0,9,8,7,6,5,4,3,2,1,.,_",
			"A̴,̴B̴,̴C̴,̴D̴,̴E̴,̴F̴,̴G̴,̴H̴,̴I̴,̴J̴,̴K̴,̴L̴,̴M̴,̴N̴,̴O̴,̴P̴,̴Q̴,̴R̴,̴S̴,̴T̴,̴U̴,̴V̴,̴W̴,̴X̴,̴Y̴,̴Z̴,̴a̴,̴b̴,̴c̴,̴d̴,̴e̴,̴f̴,̴g̴,̴h̴,̴i̴,̴j̴,̴k̴,̴l̴,̴m̴,̴n̴,̴o̴,̴p̴,̴q̴,̴r̴,̴s̴,̴t̴,̴u̴,̴v̴,̴w̴,̴x̴,̴y̴,̴z̴,̴0̴,̴9̴,̴8̴,̴7̴,̴6̴,̴5̴,̴4̴,̴3̴,̴2̴,̴1̴,̴.̴,̴_̴",
		}
		
		local tar_font = fonts[i]:split(",")
		local text = users[userid].texts
		local text = text:gsub("A",tar_font[1])
		local text = text:gsub("B",tar_font[2])
		local text = text:gsub("C",tar_font[3])
		local text = text:gsub("D",tar_font[4])
		local text = text:gsub("E",tar_font[5])
		local text = text:gsub("F",tar_font[6])
		local text = text:gsub("G",tar_font[7])
		local text = text:gsub("H",tar_font[8])
		local text = text:gsub("I",tar_font[9])
		local text = text:gsub("J",tar_font[10])
		local text = text:gsub("K",tar_font[11])
		local text = text:gsub("L",tar_font[12])
		local text = text:gsub("M",tar_font[13])
		local text = text:gsub("N",tar_font[14])
		local text = text:gsub("O",tar_font[15])
		local text = text:gsub("P",tar_font[16])
		local text = text:gsub("Q",tar_font[17])
		local text = text:gsub("R",tar_font[18])
		local text = text:gsub("S",tar_font[19])
		local text = text:gsub("T",tar_font[20])
		local text = text:gsub("U",tar_font[21])
		local text = text:gsub("V",tar_font[22])
		local text = text:gsub("W",tar_font[23])
		local text = text:gsub("X",tar_font[24])
		local text = text:gsub("Y",tar_font[25])
		local text = text:gsub("Z",tar_font[26])
		local text = text:gsub("a",tar_font[27])
		local text = text:gsub("b",tar_font[28])
		local text = text:gsub("c",tar_font[29])
		local text = text:gsub("d",tar_font[30])
		local text = text:gsub("e",tar_font[31])
		local text = text:gsub("f",tar_font[32])
		local text = text:gsub("g",tar_font[33])
		local text = text:gsub("h",tar_font[34])
		local text = text:gsub("i",tar_font[35])
		local text = text:gsub("j",tar_font[36])
		local text = text:gsub("k",tar_font[37])
		local text = text:gsub("l",tar_font[38])
		local text = text:gsub("m",tar_font[39])
		local text = text:gsub("n",tar_font[40])
		local text = text:gsub("o",tar_font[41])
		local text = text:gsub("p",tar_font[42])
		local text = text:gsub("q",tar_font[43])
		local text = text:gsub("r",tar_font[44])
		local text = text:gsub("s",tar_font[45])
		local text = text:gsub("t",tar_font[46])
		local text = text:gsub("u",tar_font[47])
		local text = text:gsub("v",tar_font[48])
		local text = text:gsub("w",tar_font[49])
		local text = text:gsub("x",tar_font[50])
		local text = text:gsub("y",tar_font[51])
		local text = text:gsub("z",tar_font[52])
		local text = text:gsub("0",tar_font[53])
		local text = text:gsub("9",tar_font[54])
		local text = text:gsub("8",tar_font[55])
		local text = text:gsub("7",tar_font[56])
		local text = text:gsub("6",tar_font[57])
		local text = text:gsub("5",tar_font[58])
		local text = text:gsub("4",tar_font[59])
		local text = text:gsub("3",tar_font[60])
		local text = text:gsub("2",tar_font[61])
		local text = text:gsub("1",tar_font[62])
		send_msg(msg.from.id, text.."\n"..bot_user, false)
		return back(msg)
	end
end

function nashr(msg)
	if msg.text == nil or msg.text == false or msg.text == "" or msg.text == " " then
		return send_msg(msg.from.id, "_You can only_ *Text Message", true)
	end
	local input = msg.text:trim()
	if input:len() > 20 then
		return send_msg(msg.from.id, "_You can only send_ *20 Characters*", true)
	end
	local input = input:upper()
	local output = ''
	local inc = 0
	for match in input:gmatch('.') do
		output = output..match..' '
	end
	local output = output..'\n'
	for match in input:sub(2):gmatch('.') do
		local spacing = ''
		for i = 1, inc do
			spacing = spacing..'  '
		end
		inc = inc + 1
		output = output..match..' '..spacing..match..'\n'
	end
	local final = "```\n"..output:trim().."\n```"
	send_msg(msg.from.id, final, true)
	return back(msg)
end

function txt_pic(msg)
	if msg.text == nil or msg.text == false or msg.text == "" or msg.text == " " then
		return send_msg(msg.from.id, "_You can only_ *Text Message", true)
	end
	if users[userid].sub == 1 then
		if string.len(msg.text) > 500 then
			return send_msg(msg.from.id, "_You can only send_ *500 Characters*", true)
		elseif string.len(msg.text) > 400 then
			users[userid].fsize = "15"
		elseif string.len(msg.text) > 300 then
			users[userid].fsize = "20"
		elseif string.len(msg.text) > 200 then
			users[userid].fsize = "25"
		elseif string.len(msg.text) > 100 then
			users[userid].fsize = "30"
		else
			users[userid].fsize = "35"
		end
		users[userid].texts = msg.text
		users[userid].sub = 2
		save_data("users.json", users)
		fonts_key = {{"Home"},{"Arial","Comic","Dyslexic"},{"Georgia","Impact","Lucida"},{"Simsun","Tahoma","Times"},{"Trebuchet","Verdana"}}
		return send_key(msg.from.id, "_choice a_ *Font* _of keys_", fonts_key, true)
	elseif users[userid].sub == 2 then
		if check_match(msg.text:lower(), {"arial","comic","dyslexic","georgia","impact","lucida","simsun","tahoma","times","trebuchet","verdana"}) then
			users[userid].font = msg.text:lower()
			users[userid].sub = 3
			save_data("users.json", users)
			color_key = {{"Home"},{"Black","Gray"},{"Green","Blue"},{"Yellow","Red"}}
			return send_key(msg.from.id, "_choice_ *Font Color* _of keys_", color_key, true)
		else
			return send_msg(msg.from.id, "_choice a_ *Font* _of keys_", true)
		end
	elseif users[userid].sub == 3 then
		if check_match(msg.text:lower(), {"black","gray","green","blue","yellow","red"}) then
			if msg.text:lower() == "black" then
				users[userid].color = "000000"
			elseif msg.text:lower() == "gray" then
				users[userid].color = "999999"
			elseif msg.text:lower() == "green" then
				users[userid].color = "00ff00"
			elseif msg.text:lower() == "blue" then
				users[userid].color = "0000ff"
			elseif msg.text:lower() == "yellow" then
				users[userid].color = "ffff00"
			elseif msg.text:lower() == "red" then
				users[userid].color = "ff0000"
			end
			users[userid].sub = 4
			save_data("users.json", users)
			color_key = {{"Home"},{"Transparent","White","Gray"},{"Green","Blue"},{"Yellow","Red"}}
			return send_key(msg.from.id, "_choice_ *Background Color* _of keys_", color_key, true)
		else
			return send_msg(msg.from.id, "_choice_ *Font Color* _of keys_", true)
		end
	elseif users[userid].sub == 4 then
		if check_match(msg.text:lower(), {"transparent","white","gray","green","blue","yellow","red"}) then
			if msg.text:lower() == "transparent" then
				bg = false
			elseif msg.text:lower() == "white" then
				bg = "ffffff"
			elseif msg.text:lower() == "gray" then
				bg = "999999"
			elseif msg.text:lower() == "green" then
				bg = "00ff00"
			elseif msg.text:lower() == "blue" then
				bg = "0000ff"
			elseif msg.text:lower() == "yellow" then
				bg = "ffff00"
			elseif msg.text:lower() == "red" then
				bg = "ff0000"
			end
			if bg then
				surl = "http://api.img4me.com/?text="..url.escape(users[userid].texts).."&font="..users[userid].font.."&fcolor="..users[userid].color.."&size="..users[userid].fsize.."&bcolor="..bg.."&type=png"
			else
				surl = "http://api.img4me.com/?text="..url.escape(users[userid].texts).."&font="..users[userid].font.."&fcolor="..users[userid].color.."&size="..users[userid].fsize.."&type=png"
			end
			file = http.request(surl)
			saved_file = "temp/dl"..msg.from.id..".png"
			file = http.request(file)
			f = io.open(saved_file, "w+")
			f:write(file)
			f:close()
			send_pic(msg.from.id, saved_file, bot_user)
			up_file(msg.from.id, saved_file, bot_user)
			return back(msg)
		else
			return send_msg(msg.from.id, "_choice_ *Background Color* _of keys_", true)
		end
	end
end

function txt_file(msg)
	if msg.text == nil or msg.text == false or msg.text == "" or msg.text == " " then
		return send_msg(msg.from.id, "_You can only_ *Text Message", true)
	end
	f = io.open("temp/"..msg.from.id..".txt", "w+")
	f:write(msg.text)
	f:close()
	up_file(msg.from.id, "temp/"..msg.from.id..".txt", "Characters: "..string.len(msg.text).."\n"..bot_user)
	return back(msg)
end

function action(msg)
	if users[userid].action == 1 then
		return send_msg(msg.from.id, "soon", true) ------------------------------------------------------- edit
	elseif users[userid].action == 2 then
		return photo_conv(msg)
	elseif users[userid].action == 3 then
		return photo_lower(msg)
	elseif users[userid].action == 4 then
		return send_msg(msg.from.id, "soon", true) ------------------------  return pdf_conv(msg)
	elseif users[userid].action == 5 then
		return app_conv(msg)
	elseif users[userid].action == 6 then
		return html_conv(msg)
	elseif users[userid].action == 7 then
		return st_pic(msg)
	elseif users[userid].action == 8 then
		return st_file(msg)
	elseif users[userid].action == 9 then
		return file_st(msg)
	elseif users[userid].action == 10 then
		return pic_st(msg)
	elseif users[userid].action == 11 then
		return pic_file(msg)
	elseif users[userid].action == 12 then
		return file_pic(msg)
	elseif users[userid].action == 13 then
		return txt_pic(msg)
	elseif users[userid].action == 14 then
		return send_msg(msg.from.id, "soon", true) ----------------------------photo>exe
	elseif users[userid].action == 15 then
		return vid_file(msg)
	elseif users[userid].action == 16 then	
		return file_vid(msg)
	elseif users[userid].action == 17 then
		return vid_gif(msg)
	elseif users[userid].action == 18 then
		return gif_vid(msg)
	elseif users[userid].action == 19 then
		return aud_voi(msg)
	elseif users[userid].action == 20 then
		return voi_aud(msg)
	elseif users[userid].action == 21 then
		return tts_voi(msg)
	elseif users[userid].action == 22 then
		return tts_aou(msg)
	elseif users[userid].action == 23 then
		return qr_reader(msg)
	elseif users[userid].action == 24 then
		return qr_voi(msg)
	elseif users[userid].action == 25 then
		return qr_make(msg)
	elseif users[userid].action == 26 then
		return bar_make(msg)
	elseif users[userid].action == 27 then
		return font(msg)
	elseif users[userid].action == 28 then
		return style(msg)
	elseif users[userid].action == 29 then
		return hash_en(msg)
	elseif users[userid].action == 30 then
		return hash_de(msg)
	elseif users[userid].action == 31 then
		return nashr(msg)
	elseif users[userid].action == 32 then
		return txt_file(msg)
	end
end

function back(msg)
	users[userid].action = 0
	save_data("users.json", users)
	return send_key(msg.from.id, "*HOME*", keyboard)
end

function check_match(txt, tab)
	ret = false
	for i=1,#tab do
		if txt == tab[i] then
			ret = true
		end
	end
	return ret
end

	if msg.text:lower() == "photo editor" then
		users[userid].action = 1
		send_key(msg.from.id, "_choice a_ *Option* _for_ *Edit Photo*", {{"Home"},{"Resize","Rotate"},{"Quality","Contrast","Brightnes"},{"Gamma","Noise","Segment","blur"},{"Radial","Border","Raise","scale"}}, true)
	elseif msg.text:lower() == "photo convertor" then
		users[userid].action = 2
		send_key(msg.from.id, "_choice a key for convert_ *Input > Output*", {{"Home"},{"PNG>JPG","JPG>PNG"},{"TIF>PNG","TIF>JPG","GIF>JPG"},{"GIF>PNG","DPX>JPG","DPX>PNG"}}, true)
	elseif msg.text:lower() == "photo lower" then
		users[userid].action = 3
		send_key(msg.from.id, "_Send a_ *Photo*\n`Maximum 3MB - 3000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "pdf convertor" then
		users[userid].action = 4
		send_key(msg.from.id, "_choice a key for convert_ *Input > Output*", {{"Home"},{"PDF>TIFF","TIFF>PDF"},{"PDF>JPG","JPG>PDF"},{"PDF>PNG","PNG>PDF"}}, true)
	elseif msg.text:lower() == "app convertor" then
		users[userid].action = 5
		send_key(msg.from.id, "_choice a key for convert_ *Input > Output*", {{"Home"},{"BAT>CMD","BAT>PIF","CMD>BAT","CMD>PIF"},{"JAR>EXE","EXE>SCR","SCR>EXE"}}, true)
	elseif msg.text:lower() == "html convertor" then
		users[userid].action = 6
		send_key(msg.from.id, "_choice a key for convert_ *Input > Output*", {{"Home"},{"HTML>PHP","HTML>ASPX","HTML>HTA"},{"HTML>JAVA","HTML>JS","HTML>EXE"}}, true)
	end
	
	if msg.text:lower() == "sticker>photo" then
		users[userid].action = 7
		send_key(msg.from.id, "_Send now a_ *Sticker*\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "sticker>file" then
		users[userid].action = 8
		send_key(msg.from.id, "_Send now a_ *Sticker*\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "file>sticker" then
		users[userid].action = 9
		send_key(msg.from.id, "_Send now a_ *File*\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "photo>sticker" then
		users[userid].action = 10
		send_key(msg.from.id, "_Send now a_ *Photo*\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "photo>file" then
		users[userid].action = 11
		send_key(msg.from.id, "_Send now a_ *Photo*\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "file>photo" then
		users[userid].action = 12
		send_key(msg.from.id, "_Send now a_ *File*\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "text>photo" then
		users[userid].action = 13
		send_key(msg.from.id, "_Send now _ *Text*\n`Maximum 500 Characters`", {{"Home"}}, true)
	elseif msg.text:lower() == "photo>exe" then
		users[userid].action = 14
		send_key(msg.from.id, "_Send now _ *Photo*\n`Maximum 10File x (1MB-1000KB)`", {{"Home"},{"Done"}}, true)
	end
	
	if msg.text:lower() == "video>file" then
		users[userid].action = 15
		send_key(msg.from.id, "_Send now a_ *Video*\n`Maximum 5MB - 5000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "file>video" then
		users[userid].action = 16
		send_key(msg.from.id, "_Send now a_ *File*\n`Maximum 5MB - 5000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "video>gif" then
		users[userid].action = 17
		send_key(msg.from.id, "_Send now a_ *Video*\n`Maximum 3MB - 3000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "gif>video" then
		users[userid].action = 18
		send_key(msg.from.id, "_Send now a_ *Gif*\n`Maximum 3MB - 3000KB`", {{"Home"}}, true)
	end
	
	if msg.text:lower() == "audio>vioce" then
		users[userid].action = 19
		send_key(msg.from.id, "_Send now a_ *Audio*\n`Maximum 3MB - 3000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "voice>audio" then
		users[userid].action = 20
		send_key(msg.from.id, "_Send now a_ *Voice*\n`Maximum 3MB - 3000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "text>voice" then
		users[userid].action = 21
		send_key(msg.from.id, "_Send now_ *Text*\n`Maximum 300 Characters`", {{"Home"}}, true)
	elseif msg.text:lower() == "text>audio" then
		users[userid].action = 22
		send_key(msg.from.id, "_Send now_ *Text*\n`Maximum 300 Characters`", {{"Home"}}, true)
	end
	
	if msg.text:lower() == "qr-code>text" then
		users[userid].action = 23
		send_key(msg.from.id, "_Send now a_ *QR Code Photo*\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "qr-code>voice" then
		users[userid].action = 24
		send_key(msg.from.id, "_Send now a_ *QR Code Photo*\n`Maximum 1MB - 1000KB`", {{"Home"}}, true)
	elseif msg.text:lower() == "text>qr-code" then
		users[userid].action = 25
		send_key(msg.from.id, "_Send now_ *Text*\n`Maximum 200 Characters`", {{"Home"}}, true)
	elseif msg.text:lower() == "text>barcode" then
		users[userid].action = 26
		send_key(msg.from.id, "_Send now_ *Text*\n`Maximum 30 Char Number`", {{"Home"}}, true)
	end
	
	if msg.text:lower() == "text>font" then
		users[userid].action = 27
		send_key(msg.from.id, "_Send now_ *Words*\n`Maximum 30 Characters`", {{"Home"}}, true)
	elseif msg.text:lower() == "text>style" then
		users[userid].action = 28
		send_key(msg.from.id, "_Send now_ *Text* _by_ *MarkDown* _format_\n`Maximum 4000 Characters`", {{"Home"},{"MarkDown Help","MarkDown Example"}}, true)
	elseif msg.text:lower() == "text>nashr" then
		users[userid].action = 31
		send_key(msg.from.id, "_Send now_ *Words*\n`Maximum 20 Characters`", {{"Home"}}, true)
	elseif msg.text:lower() == "text>file" then
		users[userid].action = 32
		send_key(msg.from.id, "_Send now_ *Words*\n`Maximum 4000 Characters`", {{"Home"}}, true)
	elseif msg.text:lower() == "text>hash-b64" then
		users[userid].action = 29
		send_key(msg.from.id, "_Send now_ *Text*\n`Maximum 200 Characters`", {{"Home"}}, true)
	elseif msg.text:lower() == "hash-b64>text" then
		users[userid].action = 30
		send_key(msg.from.id, "_Send now_ *Hash Code*\n`Maximum 1000 Characters`", {{"Home"}}, true)
	end
	
	if users[userid].action > 0 then
		users[userid].sub = 1
		return save_data("users.json", users)
	else
		return send_key(msg.from.id, "_Input is_ *False,* _select a key of keyboard_", keyboard)
	end
end

function cbinline(msg)
	tab1 = '{"type":"article","parse_mode":"Markdown","disable_web_page_preview":true,"id":'
	thumb = "http://umbrella.shayan-soft.ir/inline_icons/"
	ercomp = "مراحل ساخت کیبرد اینلاین به اتمام نرسیده است، لطفا طبق الگو عمل کنید، برای آموزش بیشتر راهنما را از داخل ربات مشاهده فرمایید.\n@KeykYazdiBot"
	if msg.query == "" or msg.query == nil then
		tab_inline = tab1..'"1","title":"متن تیتر","description":"تیتر اصلی کیبرد را وارد کنید بعد علامت # بگذارید","message_text":"'..ercomp..'","thumb_url":"'..thumb..'keyk_t.png"}'
	else
		if msg.query:find('#') then
			if msg.query:find('=') then
				if msg.query:find('>') then
					spel = msg.query:split("#")
					titr = spel[1]
					spel = spel[2]:split("=")
					keytxt = spel[1]
					spel = spel[2]:split(">")
					keyurl = spel[1]
					tab_inline = tab1..'"2","title":"اتمام مراحل","description":"کلید ساخته شد، برای ارسال کلیک کنید","message_text":"'..titr..'","thumb_url":"'..thumb..'keyk_ok.png","reply_markup":{"inline_keyboard":[[{"text":"'..keytxt..'","url":"'..keyurl..'"}]]}}'
				else
					tab_inline = tab1..'"3","title":"لینک کلید","description":"لینک کلید را با http:// وارد کنید بعد علامت > بگذارید","message_text":"'..ercomp..'","thumb_url":"'..thumb..'keyk_k.png"}'
				end
			else
				tab_inline = tab1..'"4","title":"متن کلید","description":"متن کلید را وارد کنید بعد علامت = بگذارید","message_text":"'..ercomp..'","thumb_url":"'..thumb..'keyk_k.png"}'
			end
		else
			tab_inline = tab1..'"5","title":"متن تیتر","description":"تیتر اصلی کیبرد را وارد کنید بعد علامت # بگذارید","message_text":"'..ercomp..'","thumb_url":"'..thumb..'keyk_t.png"}'
		end
	end
	return send_req(send_api.."/answerInlineQuery?inline_query_id="..msg.id.."&is_personal=true&cache_time=1&results="..url.escape('['..tab_inline..']'))
end
	bb = tonumber(msg.data)*5
	aa = bb-4
	local res,dat = http.request('http://api.varzesh3.com/v0.2/news/live/1360000')
	if dat ~= 200 then return send_msg(msg.from.id, "`سرور خارج از سرویس میباشد لطفا بعدا تلاش کنید.`", true) end
	res = json.decode(res)
	list = "`"..aa.."-"..bb.." خبر آخر فوتبال`"
	for i=aa,bb do
		if res[i].Lead then
			if string.len(res[i].Lead) > 10 then
				newstext = ":\n<code>"..res[i].Lead.."</code>"
			else
				newstext = ""
			end
		else
			newstext = ""
		end
		dandt = res[i].LastUpdate:gsub("T","   ") --getdate(res[i].Timestamp)
		list = list.."\n<code>----------------------------------</code>\n"..i.."- <b>"..dandt.."</b>\n"..res[i].Title..newstext.."\n<a href='"..res[i].Url.."'>ادامه خبر</a>"
	end
	--return edit_msg(msg.id, list, cbqkey)
	return send_inlines(msg.from.id, list, cbqkey)
end

return {launch = run, cbinline = cbinline}
