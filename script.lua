api_version = "1.10.0.0"
function OnScriptLoad()
    register_callback(cb['EVENT_CHAT'], "OnChatMessage")
    register_callback(cb['EVENT_VEHICLE_ENTER'],"OnEnterVehicle")
    register_callback(cb['EVENT_VEHICLE_EXIT'],"OnExitVehicle")
    register_callback(cb['EVENT_SPAWN'],"OnPlayerSpawn")
    register_callback(cb['EVENT_JOIN'],"OnPlayerJoin")
    register_callback(cb['EVENT_GAME_START'],"OnGameStart")
    spawn_object("vehicle","vehicles\\ghost\\ghost");
end
function OnGameStart()
   counting=false
   math.randomseed(os.time())
   say_all("Hello")
end
function pickRandom()
   id=math.random(1,tonumber(get_var(0,"$pn")))
   if player_present(id) then
	execute_command("st "..id.." blue")
   else
	pickRandom()
   end
end
function StartGame()
	for id=1,16 do
		if player_present(id) then
			execute_command("st "..id.." red")	
		end
	end
	pickRandom()
	
end
function Countdown(x)
	if tonumber(x)>0 then
		say_all("Game will start in "..x.." seconds")
		timer(1000,"Countdown",tostring(x-1))
		return false
	else
		say_all("Game start UwU")
		StartGame()	
		return false
	end
end
function OnPlayerJoin(PlayerIndex)
    if tonumber(get_var(0,"$pn"))>1 and not counting then
       	   counting=true
	   timer(1000,"Countdown","5")
    elseif player_present(PlayerIndex) and counting then
	   execute_command("st "..PlayerIndex.." blue")
    end
end
function OnPlayerSpawn(PlayerIndex)
    execute_command("wdel "..PlayerIndex.." 5")
    if get_var(PlayerIndex,"$team")=="blue" then
    	new_weap=spawn_object("weap","weapons\\pistol\\pistol")
        new_weap2=spawn_object("weap","weapons\\sniper rifle\\sniper rifle")
        new_weap3=spawn_object("weap","weapons\\shotgun\\shotgun")
        assign_weapon(new_weap,PlayerIndex)
        assign_weapon(new_weap2,PlayerIndex)
        assign_weapon(new_weap3,PlayerIndex)
    else 
	new_weap=spawn_object("weap","weapons\\plasma_cannon\\plasma_cannon")
	new_weap2=spawn_object("weap","weapons\\needler\\mp_needler")
	new_weap3=spawn_object("weap","weapons\\assault rifle\\assault rifle")
        assign_weapon(new_weap,PlayerIndex)
        assign_weapon(new_weap2,PlayerIndex)
        assign_weapon(new_weap3,PlayerIndex)
end
end
function OnEnterVehicle(PlayerIndex)
	say_all(get_var(PlayerIndex,"$name").." enter a vehicle")
end
function OnExitVehicle(PlayerIndex)
	say_all(get_var(PlayerIndex,"$name").." exit a vehicle")
end
function Ungod(PlayerIndex)
	print(PlayerIndex)
	execute_command("ungod "..PlayerIndex)
end
function OnChatMessage(PlayerIndex, Message, Type)
    if Message=="/ocultar" then
	return true
    end
    if Message=="teleport" then
	say_all("teleporting")
	execute_command("god "..PlayerIndex)
	execute_command("m "..PlayerIndex.." 100 100 100")
	say_all(get_var(PlayerIndex,"$x").." "..get_var(PlayerIndex,"$y").." "..get_var(PlayerIndex,"$x"))
	timer(10000,"Ungod",tostring(PlayerIndex))
    end
end