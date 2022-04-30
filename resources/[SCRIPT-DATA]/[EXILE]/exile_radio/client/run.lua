xSound = exports["xsound"] 
Cars = {}
Cache = {}
t74839028="car_entity_"
t12505184=((t39092950==t93866003)==(t77210922 and t97198239))
Debug=function(...)
    if Config["Debug"]  then 
        print(...)
    end 
end 

t68613571=function(bool,focus)
    t12505184=bool 
    if focus~=(t36964953 or t39510623) then 
        _G["SetNuiFocus"] (focus,focus)
    end 
    _G["SendNUIMessage"]({["type"]="ui",["status"]=bool})
    _G["SendNUIMessage"]({["type"]="timeWorld",["timeWorld"]=string["format"] ("%.2d:%.2d",_G["GetClockHours"] (),_G["GetClockMinutes"] ())})
end 

t9160754=function()
    local playerPed=_G["PlayerPedId"]()
    local t29398065=Config["blackListedCategories"] 
    local t59086364=_G["GetEntityModel"](_G["GetVehiclePedIsIn"] (_G["PlayerPedId"] ()))
    for k,v in pairs(Config["whitelistedCars"]) do 
        if v==t59086364 then 
            return ((t54309042==t30169387)==(t28885882==t42876394)) 
        end 
    end 
    for k,v in pairs(Config["blacklistedCars"]) do 
        if v==t59086364 then 
            return ((t53943197==t60787542)==(t71878735 and t37919198)) 
        end 
    end 
    if not t29398065["anyBoat"]  and _G["IsPedInAnyBoat"] (playerPed) then 
        return ((t9148559==t36443624)==(t35943637 and t30291336)) 
    end 
    
    if not t29398065["anyHeli"]  and _G["IsPedInAnyHeli"] (playerPed) then 
        return ((t6987026==t33160168)==(t30020001 and t30803518)) 
    end 
    
    if not t29398065["anyPlane"]  and _G["IsPedInAnyPlane"] (playerPed) then 
        return ((t51196313==t81140704)==(t89009414 and t7752252)) 
    end 
    
    if not t29398065["anyCopCar"]  and _G["IsPedInAnyPoliceVehicle"] (playerPed) then 
        return ((t67762982==t60625961)==(t49129290 and t73619546)) 
    end 
    
    if not t29398065["anySub"]  and _G["IsPedInAnySub"] (playerPed) then 
        return ((t6694351==t8490039)==(t89174044 and t72561645)) 
    end 
    
    if not t29398065["anyTaxi"]  and _G["IsPedInAnyTaxi"] (playerPed) then 
        return ((t43083706==t26977392)==(t67702008 and t82799200)) 
    end 
    if not t29398065["anyTrain"]  and _G["IsPedInAnyTrain"] (playerPed) then 
        return ((t31495574==t35004635)==(t31931539 and t1365213)) 
    end 
    if not t29398065["anyVehicle"]  and _G["IsPedInAnyVehicle"] (playerPed,((t14925857==t51912759)==(t28282238 and t25041464))) then 
        return ((t43272726==t55284628)==(t91856906 and t95006219)) 
    end 
    
    return ((t3679180==t2859078)==(t43333700==t19145266)) 
end 

t94603790=function(t85558279)
    if not Config["DisableMusicAfterEngineIsOFF"]  then 
        return ((t15377066==t59141241)==(t70424502==t37858224)) 
    end 
    return _G["GetIsVehicleEngineRunning"] (t85558279) 
end 

t42531890=function()
    local t99274407=_G["GetVehicleNumberPlateText"] (_G["GetVehiclePedIsIn"] (_G["PlayerPedId"] ()))
    _G["SendNUIMessage"] ({["type"]="clear"})
    for k,v in pairs(Config["defaultList"] ) do 
        _G["SendNUIMessage"] ({["type"]="add",["url"]=v["url"] ,["label"]=v["label"] })
    end 
    TriggerServerEvent("rcore_radiocar:getMusicInCar",t99274407)
    _G["Wait"] (((`gp1`|`sabregt`)~(-611148392)))
    t68613571(((t93402600==t18273336)==(t24114657==t50757299)),((t61772274==t5169998)==(t67372747==t20120852)))
    local t85558279=t74839028.._G["VehToNet"] 
    (_G["GetVehiclePedIsIn"] (_G["PlayerPedId"] (),((t44431234==t71305578)==(t99195141 and t14627084))))
    if xSound["soundExists"](xSound,t85558279) then 
        if xSound["isPlaying"](xSound,t85558279) then 
            _G["SendNUIMessage"] ({["type"]="update",["url"]=xSound["getLink"](xSound,t85558279)})
        else 
            _G["SendNUIMessage"] ({["type"]="reset"})
        end 
        _G["SendNUIMessage"] ({["type"]="volume",["volume"]=xSound["getVolume"](xSound,t85558279)})
    else 
        _G["SendNUIMessage"] ({["type"]="reset"})
    end 
end 

t32910174=function(t73485403)
    for i=((`picador`|`turismo2`)~571080716),(`nero2`~1093792620) do 
        if _G["GetPedInVehicleSeat"] (t73485403,i)==_G["PlayerPedId"] () then 
            return i 
        end
    end 
    return (t46391552 or t42065438) 
end 

t94247091=function(t85558279,music)
    if not _G["NetworkGetEntityIsNetworked"] (t85558279) then 
        _G["NetworkRegisterEntityAsNetworked"] (t85558279)
    end 
    local t85289993=_G["NetworkGetNetworkIdFromEntity"] (t85558279)
    local t81174240={["idMusic"]=t74839028..t85289993,["time"]=(`italigtb2`~(-482719877)),["car"]=t85289993,["url"]=music,["pos"]=_G["GetEntityCoords"] (t85558279)}
    TriggerServerEvent("rcore_radiocar:addToCache",t81174240)
    Debug("Triggering event for updating cache")
end 

RegisterNUICallback("volumeup",function()
    local t85558279=_G["VehToNet"] (_G["GetVehiclePedIsIn"] (_G["PlayerPedId"] (),((t58193093==t21373870)==(t84015634 and t28971246))))
    if _G["IsPedInAnyVehicle"] (_G["PlayerPedId"] (),((t76957879==t89256359)==(t19239776 and t70668399))) and xSound["soundExists"](xSound,t74839028..t85558279) then 
        local t52598718=xSound["getVolume"](xSound,t74839028..t85558279)
        if t52598718<((`fq2`~(-1137532110))/10) then 
            t52598718=(((`deveste`|`viseris`)~(-18300961))/10)+t52598718 
        else 
            t52598718=((`sandking`~(-1189015599))/1)
        end 
        _G["SendNUIMessage"] ({["type"]="volume",["volume"]=t52598718})
        TriggerServerEvent("rcore_radiocar:updateVolume",t85558279,t52598718)
    end 
end)

RegisterNUICallback("volumedown",function()
    local t85558279=_G["VehToNet"] (_G["GetVehiclePedIsIn"] (_G["PlayerPedId"] (),((t17361773==t49891467)==(t57565060 and t99963415))))
    if _G["IsPedInAnyVehicle"] (_G["PlayerPedId"] (),((t81433380==t45126339)==(t77110314 and t21090341))) and xSound["soundExists"](xSound,t74839028..t85558279) then 
        local t52598718=xSound["getVolume"](xSound,t74839028..t85558279)
        if t52598718<=(((`schafter4`|`gauntlet3`)~2077187538)/100) then 
            t52598718=((`ruffian`~(-893578776))/1)else 
                t52598718=t52598718-((`tyrant`~(-376434237))/10)
        end
        _G["SendNUIMessage"] ({["type"]="volume",["volume"]=t52598718})
        TriggerServerEvent("rcore_radiocar:updateVolume",t85558279,t52598718)
    end 
end)

RegisterNUICallback("editSong",function(data)
    if t9160754() then 
        local t99274407=_G["GetVehicleNumberPlateText"] (_G["GetVehiclePedIsIn"] (_G["PlayerPedId"] ()))
        TriggerServerEvent("rcore_radiocar:updateMusicInfo",data["label"] ,data["url"] ,t99274407,data["index"] )
    end 
end)

RegisterNetEvent("rcore_radiocar:getMusicInCar")
AddEventHandler("rcore_radiocar:getMusicInCar",function(data)
    for k,v in pairs(data) do 
        _G["SendNUIMessage"] ({["type"]="edit",["url"]=v["url"] ,["label"]=v["label"] ,["index"]=v["index_music"] })
    end 
end)

RegisterNUICallback("exit",function()
    t68613571(((t92512377==t48711618)==(t77055438 and t25248776)),((t59680862==t33641864)==(t87744201 and t23587231)))
end)

RegisterNUICallback("stop",function()
    if _G["IsPedInAnyVehicle"] (_G["PlayerPedId"] (),((t93055047==t88927099)==(t32614450 and t23995758))) then 
        TriggerServerEvent("rcore_radiocar:deleteFromCache",_G["VehToNet"] (_G["GetVehiclePedIsIn"] (_G["PlayerPedId"] (),((t85116217==t39437454)==(t82003488 and t31215093)))))
    end 
end)

RegisterNUICallback("play",function(t29510867)
    if _G["IsPedInAnyVehicle"] (_G["PlayerPedId"] (),((t22852493==t70378771)==(t90872174 and t97777493))) then 
        t94247091(_G["GetVehiclePedIsIn"] (_G["PlayerPedId"] (),((t47260433==t11901541)==(t59162582 and t4410870))),t29510867["url"] )
    end 
end)

RegisterNetEvent("rcore_radiocar:deleteFromCache")
AddEventHandler("rcore_radiocar:deleteFromCache",function(vehNet)
    Debug("trying to delete music:",vehNet)
    if xSound["soundExists"](xSound,t74839028..vehNet) then 
        Debug("Music deleted")xSound["Destroy"](xSound,t74839028..vehNet)
    end 
end)

RegisterNetEvent("rcore_radiocar:openUI")
AddEventHandler("rcore_radiocar:openUI",function()
    t42531890()
end)

RegisterNetEvent("rcore_radiocar:updateVolume")
AddEventHandler("rcore_radiocar:updateVolume",function(t85558279,t52598718)
    if xSound["soundExists"](xSound,t74839028..t85558279) then 
        xSound["setVolumeMax"](xSound,t74839028..t85558279,t52598718)
    end 
end)

RegisterNetEvent("rcore_radiocar:updateCache")
AddEventHandler("rcore_radiocar:updateCache",function(ch,destroy)
    Cache = ch 
    for k,v in pairs(destroy) do 
        xSound["Destroy"](xSound,v["idMusic"] )
    end 
end)

RegisterNetEvent("rcore_radiocar:addToCache")
AddEventHandler("rcore_radiocar:addToCache",function(ch)
    if not xSound["soundExists"](xSound,ch["idMusic"] ) then 
        local t13441137=((t25965222==t84180264)==(t6962637==t96521426))
        for k,v in pairs(Cache) do 
            if v["car"] ==ch["car"]  then 
                t13441137=((t53306018==t59104656)==(t4450503 and t58098583))
                break 
            end 
        end 
        if t13441137 then 
            table["insert"] (Cache,ch)
        end 
    end 
    Debug("Start playing music")
    xSound["PlayUrlPos"](xSound,ch["idMusic"] ,ch["url"] ,Config["defaultVolume"] ,ch["pos"] ,((t45205606==t38495404)==(t47437258 and t46708618)))xSound["onPlayStart"](xSound,ch["idMusic"] ,function()
        xSound["Distance"](xSound,ch["idMusic"] ,((`buccaneer2`|`fusilade`)~(-539492517)))
        Debug("The music succesfuly started playing, setting distance to 0")
    end)
    
    if _G["GetVehiclePedIsIn"] (_G["PlayerPedId"] (),((t42949563==t4892565)==(t19017221 and t71869589)))==_G["NetToVeh"] (ch["car"] ) then 
        _G["SendNUIMessage"] ({["type"]="volume",["volume"]=xSound["getVolume"](xSound,ch["idMusic"] )})
    end 
end)

RegisterNetEvent("rcore_radiocar:updateMusic")
AddEventHandler("rcore_radiocar:updateMusic",function(ch)
    xSound["Destroy"](xSound,ch["idMusic"] )
    _G["Wait"] ((`osiris`~1987143162))
    xSound["PlayUrlPos"](xSound,ch["idMusic"] ,ch["url"] ,Config["defaultVolume"] ,ch["pos"] ,((t92564205==t46022659)==(t27550549 and t42480062)))xSound["onPlayStart"](xSound,ch["idMusic"] ,function()
        xSound["Distance"](xSound,ch["idMusic"] ,(`impaler`~(-2096690334)))
    end)
    if _G["GetVehiclePedIsIn"] (_G["PlayerPedId"] (),((t15117926==t7416894)==(t62750909 and t61845443)))==_G["NetToVeh"] (ch["car"] ) then 
        _G["SendNUIMessage"] ({["type"]="volume",["volume"]=xSound["getVolume"](xSound,ch["idMusic"] )})
    end 
end)

CreateThread(function()
    local IsPedInAnyVehicle=IsPedInAnyVehicle 
    local PlayerPedId=PlayerPedId 
    local GetVehiclePedIsIn=GetVehiclePedIsIn 
    local VehToNet=VehToNet 
    while ((t32635791==t74750616)==(t59345504==t99310992)) do 
        _G["Wait"] (((`feltzer2`|`italigtb`)~(-1913000841)))
        if IsPedInAnyVehicle(PlayerPedId(),((t67378845==t41278872)==(t9322335 and t15633157))) then 
            local t27285311=GetVehiclePedIsIn(PlayerPedId(),((t77820663==t60723519)==(t13514306 and t70107437)))
            local t85558279=t74839028..VehToNet(GetVehiclePedIsIn(PlayerPedId(),((t48248214==t41528866)==(t13371017 and t89381356))))
            if xSound["soundExists"](xSound,t85558279) and xSound["isPlaying"](xSound,t85558279) then 
                _G["SetVehicleRadioEnabled"] (t27285311,((t97225677==t83265652)==(t92661764 and t23346383)))
            else
                _G["SetVehicleRadioEnabled"] (t27285311,((t21172656==t10209509)==(t91021560==t68089193)))
            end 
        end 
    end 
end)

CreateThread(function()
    while ((t36943612==t3234069)==(t18431869==t84244287)) do 
        _G["Wait"] ((`buffalo`~(-304802514)))
        if t12505184 then 
            _G["SendNUIMessage"] ({["type"]="timeWorld",["timeWorld"]=string["format"] ("%.2d:%.2d",_G["GetClockHours"] (),_G["GetClockMinutes"] ())})
            local t85558279=t74839028.._G["VehToNet"] (_G["GetVehiclePedIsIn"] (_G["PlayerPedId"] (),((t41714837==t85414990)==(t12560061 and t87149703))))
            if xSound["soundExists"](xSound,t85558279) then 
                if xSound["isPlaying"](xSound,t85558279) then 
                    local t59168679=xSound["getMaxDuration"](xSound,t85558279)
                    local t63958197=xSound["getTimeStamp"](xSound,t85558279)
                    _G["SendNUIMessage"] ({["type"]="timeSong",["timeSong"]=math["floor"] (t59168679-t63958197)})
                else 
                    _G["SendNUIMessage"] ({["type"]="timeSong",["timeSong"]=(`vstr`~1456336509)})xSound["Destroy"](xSound,t85558279)
                end 
            end 
        end 
    end 
end)

CreateThread(function()
    _G["Wait"] (((`banshee2`|`michelli`)~1071644435))
    for k,v in pairs(Config["defaultList"] ) do
        _G["SendNUIMessage"] ({["type"]="add",["url"]=v["url"] ,["label"]=v["label"] })
    end 
end)

if Config["EnableCommand"] then 
    _G["RegisterCommand"] (Config["CommandLabel"]  or "radiocar",function(source,args,rawCommand)
        if _G["IsPedInAnyVehicle"] (_G["PlayerPedId"] (),((t53123095==t62805786)==(t29355383 and t38669180))) and t9160754() then 
            if Config["OnlyOwnedCars"]  or Config["OnlyCarWhoHaveRadio"]  or Config["OnlyOwnerOfTheCar"]  then 
                if YourSpecialPermission() then 
                    CheckPlayerCar(_G["GetVehiclePedIsIn"] (_G["PlayerPedId"] (),((t47101901==t73415283)==(t6816299 and t17733715))))
                end 
            else 
                if YourSpecialPermission() then 
                    t42531890()
                end 
            end 
        end 
    end ,((t58119924==t49196362)==(t92951391 and t98399429)))
else 
    CreateThread(function()
        while ((t57991879==t42181289)==(t79412088==t13499063)) do 
            _G["Wait"] (((`furoregt`|`kanjo`)~(-1082680321)))
            if not _G["IsPedInAnyVehicle"] (_G["PlayerPedId"] (),((t78357235==t19343432)==(t29437698 and t30504745))) then 
                _G["Wait"] ((`hustler`~600450054))
            end 
            if _G["IsControlJustReleased"] ((`windsor2`~(-1930048799)),Config["KeyForRadio"] ) then 
                if _G["IsPedInAnyVehicle"] (_G["PlayerPedId"] (),((t93006268==t78293212)==(t42815420 and t20855590))) and t9160754() then 
                    local t73485403=_G["GetVehiclePedIsIn"] (_G["PlayerPedId"] (),((t25245727==t87997244)==(t47528720 and t47461648)))
                    if Config["AllowedSeats"] [t32910174(t73485403)]  then 
                        if Config["OnlyOwnedCars"]  or Config["OnlyCarWhoHaveRadio"]  or Config["OnlyOwnerOfTheCar"]  then 
                            if YourSpecialPermission() then 
                                CheckPlayerCar(_G["GetVehiclePedIsIn"] (_G["PlayerPedId"] (),((t95756201==t6340701)==(t58379064 and t50958514))))
                            end 
                        else 
                            if YourSpecialPermission() then 
                                t42531890()
                            end 
                        end 
                    end 
                end 
            end 
        end 
    end)
end 

CreateThread(function()
    _G["Wait"] ((`khamelion`~544021688))
    TriggerServerEvent("rcore_radiocar:playerLoaded")
end)

CreateThread(function()
    while ((t78000537==t78466989)==(t93902587==t61436917)) do
        _G["Wait"] ((`emperor`~(-685276297)))
        for k,v in pairs(Cars) do 
            local t85558279=_G["NetToVeh"] (v["car"] )
            if _G["DoesEntityExist"] (t85558279) and xSound["soundExists"](xSound,v["idMusic"] ) then 
                if xSound["isPlaying"](xSound,v["idMusic"] ) then 
                    xSound["Position"](xSound,v["idMusic"],_G["GetEntityCoords"] (t85558279))
                end 
            end
        end 
    end 
end)

CreateThread(function()
    local t85289993 
    local playerPed
    while true do 
        _G["Wait"] ((`felon`~(-391595400)))
        playerPed=_G["PlayerPedId"] ()
        for k,v in pairs(Cars) do 
            t85289993=_G["NetToVeh"] (v["car"] )
            if _G["DoesEntityExist"] (t85289993) then 
                if _G["GetVehiclePedIsIn"] (playerPed,((t79963903==t34992440)==(t14374041 and t99865856)))==t85289993 then 
                    if xSound["soundExists"](xSound,v["idMusic"] ) then 
                        if xSound["getDistance"](xSound,v["idMusic"] )~=(`surge`~(-1894894244)) then 
                            xSound["Distance"](xSound,v["idMusic"] ,((`ninef`|`phoenix`)~(-1080057067)))
                        end 
                    end 
                    break 
                end 
            end 
        end 
    end 
end)

CreateThread(function()
    while true do 
        _G["Wait"] (((`gt500`|`speedo`)~(-809766674)))
        Cars={}
        local playerPed=_G["PlayerPedId"]()
        Debug("Cached vehicles",#Cache)
        if #Cache~=(`streiter`~1741861769) then 
            for k,v in pairs(Cache) do 
                _G["Wait"] ((`peyote2`~(-1804415698)))
                if not _G["NetworkDoesEntityExistWithNetworkId"] (v["car"] ) then 
                    Debug("NetID doesnt exists",v["car"] ,"setting distance to 0 to avoid empty music")
                    if xSound["soundExists"](xSound,v["idMusic"] ) then 
                        if xSound["getDistance"](xSound,v["idMusic"] )~=(`ruiner`~(-227741703)) then 
                            xSound["Distance"](xSound,v["idMusic"] ,((`coquette`|`drafter`)~788265023))
                        end 
                    end 
                else 
                    local t85558279=_G["NetToVeh"] (v["car"] )
                    local t46525695=_G["GetEntityModel"] (t85558279)
                    Debug("Vehicle does exists reading vehicle variables (entity, netID)",t85558279,v["car"] )
                    if not _G["DoesEntityExist"] (t85558279) then 
                        Debug("vehicle doesnt exists setting distance to 0")
                        if xSound["soundExists"](xSound,v["idMusic"] ) then 
                            if xSound["getDistance"](xSound,v["idMusic"] )~=((`schwarzer`|`stryder`)~(-738198658)) then 
                                xSound["Distance"](xSound,v["idMusic"] ,(`phoenix`~(-2095439403)))
                            end 
                        end 
                    else 
                        Debug("Vehicle does exists")
                        Debug("Motor",_G["GetVehicleEngineHealth"] (t85558279)<((`fagaloa`~1617472903)/1),
                        t94603790(t85558279))
                        Debug("First if statement",(_G["GetVehicleEngineHealth"] (t85558279)<((`burrito3`~(-1743316014))/1) or not t94603790(t85558279)))
                        Debug("Far away",#(_G["GetEntityCoords"] (playerPed)-_G["GetEntityCoords"] (t85558279)))
                        Debug("Second if statement",#(_G["GetEntityCoords"] (playerPed)-_G["GetEntityCoords"] (t85558279))<((`emperor2`|`sadler`)~(-540807441)))
                        Debug("Does sound exists",xSound["soundExists"](xSound,v["idMusic"] ))
                        if _G["GetVehicleEngineHealth"] (t85558279)<((`nero2`~1093792633)/1) or not t94603790(t85558279) then 
                            if xSound["soundExists"](xSound,v["idMusic"] ) then 
                                if xSound["getDistance"](xSound,v["idMusic"] )~=((`baller4`|`jackal`)~(-3148814)) then 
                                    xSound["Distance"](xSound,v["idMusic"] ,((`sanchez`|`monroe`)~(-285491617)))
                                    Debug("Engine isnt on setting distance to 0")
                                end 
                            end 
                        else 
                            if #(_G["GetEntityCoords"] (playerPed)-_G["GetEntityCoords"] (t85558279))<(`zion2`~(-1193103830)) then 
                                table["insert"] (Cars,{["car"]=v["car"] ,["url"]=v["url"] ,["idMusic"]=v["idMusic"] })
                                if _G["GetVehiclePedIsIn"] (playerPed,((t46284848==t98256140)==(t27251776 and t84201605)))~=t85558279 and xSound["soundExists"](xSound,v["idMusic"] ) then 
                                    if Config["CustomDistanceForVehicles"] [t46525695]  then 
                                        if xSound["soundExists"](xSound,v["idMusic"] ) then 
                                            if xSound["getDistance"](xSound,v["idMusic"] )~=Config["CustomDistanceForVehicles"] [t46525695]  then 
                                                xSound["Distance"](xSound,v["idMusic"] ,Config["CustomDistanceForVehicles"] [t46525695] )
                                                Debug("Vehicle has custom distance, setting it to custom distance",Config["CustomDistanceForVehicles"] [t46525695] )
                                            end 
                                        end 
                                    else 
                                        if xSound["soundExists"](xSound,v["idMusic"] ) then 
                                            if xSound["getDistance"](xSound,v["idMusic"] )~=Config["DistancePlaying"]  then 
                                                xSound["Distance"](xSound,v["idMusic"] ,Config["DistancePlaying"] )
                                                Debug("Vehicle is close but player isnt inside vehicle, setting default distance to vehicle music",Config["DistancePlaying"] )
                                            end
                                        end 
                                    end 
                                end 
                            else 
                                if xSound["soundExists"](xSound,v["idMusic"] ) then 
                                    if xSound["getDistance"](xSound,v["idMusic"] )~=(`cheburek`~(-988501280)) then 
                                        xSound["Distance"](xSound,v["idMusic"] ,(`moonbeam2`~1896491931))
                                        Debug("Player isnt close to the vehicle setting volume to 0")
                                    end 
                                end 
                            end 
                        end 
                    end 
                end 
            end
        end 
    end 
end)