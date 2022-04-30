t9831469={}
t89436233={}
t69174533=function(...)
    if Config["Debug"]  then 
        print(...)
    end 
end 
t92042877=function(t8331506)
    if not t92484939(t8331506) then 
        if t89436233[t8331506] ==(t88936245 or t1264605) then 
            MySQLSyncexecute("INSERT INTO radiocar_owned (spz) VALUES (@spz)",{
                ["@spz"]=t8331506}
            )t89436233[t8331506] =((t48678082==t59933905)==(t96533621==t31175460))
            end 
        end 
    end 
    exports("GiveRadioToCar",t92042877)

    t92484939=function(t8331506)
        return t89436233[t8331506] ~=(t76534109 or t95198287) 
    end 
    exports("HasCarRadio",t92484939)

    t48775640=function(t8331506)
        if t89436233[t8331506] ~= (t17651400 or t35873516) then 
            MySQLSyncexecute("DELETE FROM radiocar_owned WHERE radiocar_owned.spz = @spz",{["@spz"]=t8331506})t89436233[t8331506] =(t13117974 or t71458013)
        end
    end 
    exports("RemoveRadioFromCar",t48775640)
    MySQLAsyncfetchAll("SELECT * FROM radiocar_owned",{},function(t46769592)
        for k,v in pairs(t46769592) do 
            t89436233[v["spz"] ] =((t18456259==t84119290)==(t98237847==t78881613))
        end 
    end )
    t57372991=function()
        SetTimeout(((`surge`|`mamba`)~(-1610613186)),t57372991)
        for k,v in pairs(t9831469) do 
            v["time"] =((`phoenix`|`faggio3`)~(-1287999012))+v["time"] 
        end 
    end 
    SetTimeout(((`schafter4`|`manana`)~(-638625228)),t57372991)t46422039=function()
        SetTimeout(((`stanier`|`washington`)~(-268571465)),t46422039)
        local t43672106 
        local t14465502=((t47034829==t25565841)==(t52857858 and t97865905))
        local t21023269={}
        for k,v in pairs(t9831469) do 
            t43672106=_G["NetworkGetEntityFromNetworkId"] (v["car"] )
            if not _G["DoesEntityExist"] (t43672106) then 
                table["insert"] (t21023269,v)
                table["remove"] (t9831469,k)
                t14465502=((t84954635==t97195190)==(t69473306==t87360064))
            end 
        end 
        if t14465502 then 
            TriggerClientEvent("rcore_radiocar:updateCache",(`cog55`~(-906642319)),t9831469,t21023269)
        end 
    end 
    t75515841=function(t8331506,label,url,index)
        MySQLAsyncexecute("INSERT INTO radiocar (id,label,url,spz,index_music) VALUES (null,@label,@url,@spz,@index_music)",{["@label"]=label,["@url"]=url,["@spz"]=t8331506,["@index_music"]=index})
    end 
    t46754348=function(t8331506,label,url,index)
        MySQLAsyncexecute("UPDATE radiocar SET label = @label, url = @url WHERE spz = @spz AND index_music = @index_music",{["@label"]=label,["@url"]=url,["@spz"]=t8331506,["@index_music"]=index})
    end 
    t5910833=function(label,url,t8331506,index)
        MySQLAsyncfetchAll("SELECT * FROM radiocar WHERE spz = @spz AND index_music = @index",{["@spz"]=t8331506,["@index"]=index},
        function(t46769592)
            if #t46769592==(`panto`~(-431692672)) then 
                t75515841(t8331506,label,url,index)
            else 
                t46754348(t8331506,label,url,index)
            end 
        end)
    end 
    RegisterNetEvent("rcore_radiocar:updateMusicInfo")
    AddEventHandler("rcore_radiocar:updateMusicInfo",function(label,url,t8331506,index)
        local t28428576=source 
        if Config["OnlyCarWhoHaveRadio"]  then 
            if t92484939(t8331506) then 
                t5910833(label,url,t8331506,index)
            end 
            return  
        end 
        if Config["OnlyOwnedCars"]  then 
            IsVehiclePlayer(t28428576,t8331506,function(owner)
                if owner then 
                    t5910833(label,url,t8331506,index)
                end 
            end)
            return  
        end 
        t5910833(label,url,t8331506,index)
    end)
    RegisterNetEvent("rcore_radiocar:getMusicInCar")
    AddEventHandler("rcore_radiocar:getMusicInCar",function(t8331506)
        local t56763250=source 
        local t46769592= MySQLSyncfetchAll("SELECT * FROM radiocar WHERE spz = @spz",{["@spz"]=t8331506})
        TriggerClientEvent("rcore_radiocar:getMusicInCar",t56763250,t46769592)
    end)
    RegisterNetEvent("rcore_radiocar:fetchCache")
    AddEventHandler("rcore_radiocar:fetchCache",function()
        TriggerClientEvent("rcore_radiocar:fetchCache",source,t9831469)
    end)
    RegisterNetEvent("rcore_radiocar:addToCache")
    AddEventHandler("rcore_radiocar:addToCache",function(ch)
        local t61004000=((t94664764==t44717813)==(t63793566==t94420867))
        for k,v in pairs(t9831469) do 
            if v["car"] ==ch["car"]  then 
                t61004000 = ((t2941394==t33788201)==(t50516452 and t88466744))v["url"] = ch["url"] 
                break 
            end 
        end 
        if t61004000 then 
            table["insert"] (t9831469,ch)
            TriggerClientEvent("rcore_radiocar:addToCache",(`vstr`~(-1456336510)),ch)
        else 
            local t43672106=_G["NetworkGetEntityFromNetworkId"] (ch["car"] )ch["pos"] = _G["GetEntityCoords"] (t43672106)
            TriggerClientEvent("rcore_radiocar:updateMusic",((`faggio`|`zion`)~1086587412),ch)
        end 
    end)
    RegisterNetEvent("rcore_radiocar:deleteFromCache")
    AddEventHandler("rcore_radiocar:deleteFromCache",function(carNet)
        for k,v in pairs(t9831469) do 
            if v["car"] ==carNet then 
                v["delete"] =((t10822299==t82405917)==(t60357675==t72826882))
                TriggerClientEvent("rcore_radiocar:deleteFromCache",(`habanero`~(-884422928)),carNet)
                break 
            end 
        end 
    end)
    RegisterNetEvent("rcore_radiocar:updateVolume")
    AddEventHandler("rcore_radiocar:updateVolume",function(t24553671,t25172558)
        TriggerClientEvent("rcore_radiocar:updateVolume",((`cognoscenti`|`habanero`)~1224787088),t24553671,t25172558)
    end)
    RegisterNetEvent("rcore_radiocar:playerLoaded")
    AddEventHandler("rcore_radiocar:playerLoaded",function()
        TriggerClientEvent("rcore_radiocar:playFromCache",source,t9831469)
    end)