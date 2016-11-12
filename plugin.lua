function run(msg)
	sudo = {{"اضافه کردن تعداد محصول","آمار ادمین ها","لیست فروش ادمین ها"},{"قیمت کل فروش","تعیین تعداد محصول","اضافه کردن تعداد محصول به لیست"}}
        member = {{"کل محصولات","لیست محصولات","موجودی محصولات"},{"سایت شرکت","لینک پرداخت","ارتباط با ما"}}
	chat = {{"ارسال درخواست چت"},{text="ارسال شماره شما",request_contact=true},{text="ارسال مکان شما",request_location=true}}
	start = "`سلام`\n`به این روبات خوش آمدید!`\n`لطفا از کیبورد اصتفاده کنید!`"
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
	    if msg.from.id == sudo_id then
		users[userid] = true
		save_data("users.json", users)
		send_inline(msg.from.id, start, sudo)
		return send_key(msg.from.id, "`منوی اصلی:`", sudo)
	    else
		users[userid] = true
		save_data("users.json", users)
		send_inline(msg.from.id, start, member)
		return send_key(msg.grom.id, "`منوی اصلی:`", member)
	end
	
	if msg.text == "/start" then
	    if msg.from.id == sudo_id then
		users[userid] = true
		save_data("users.json", users)
		send_inline(msg.from.id, start, sudo)
		return send_key(msg.from.id, "`منوی اصلی:`", sudo)
	    else
		users[userid] = true
		save_data("users.json", users)
		send_inline(msg.from.id, start, member)
		return send_key(msg.grom.id, "`منوی اصلی:`", member)
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
	elseif msg.text == "ارسال درخواست چت" then
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
	elseif msg.text:find('/setlist') and msg.chat.id == admingp then
		local usertarget = msg.text:input()
		if usertarget then
			if list[tostring(usertarget)] then
				list[tostring(usertarget)] = false
				save_data("list.json", list)
				return send_msg(admingp, "`ذخیره شد`", true)
			end
			return send_msg(admingp, "`ذخیره نشده است`", true)
		else
			return send_msg(admingp, "`بعد از این دستور آی دی شخص مورد نظر را با درج یک فاصله وارد کنید`", true)
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

function cbinline(msg)
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
