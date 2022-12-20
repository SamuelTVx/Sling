local currentWeapon = -1569615261
local Sling = {}

Sling[1]={
		WeaponIsSlinged = false,
		WeaponObject = nil,
		Weapon = nil,
		Ammo = nil,
	}

Sling[2]={
		WeaponIsSlinged = false,
		WeaponObject = nil,
		Weapon = nil,
		Ammo = nil,
	}
	
Sling[3]={
		WeaponIsSlinged = false,
		WeaponObject = nil,
		Weapon = nil,
		Ammo = nil,
	}
	
Sling[4]={
		WeaponIsSlinged = false,
		WeaponObject = nil,
		Weapon = nil,
		Ammo = nil,
	}
	
Sling[5]={
		WeaponIsSlinged = false,
		WeaponObject = nil,
		Weapon = nil,
		Ammo = nil,
	}
	
Sling[6]={
		WeaponIsSlinged = false,
		WeaponObject = nil,
		Weapon = nil,
		Ammo = nil,
	}

RegisterCommand(Config.Command, function(source, raw)
	local pl = GetPlayerPed(-1)
	if source then
		unsling(1,pl,weapon1)
		unsling(2,pl,weapon2)
		unsling(3,pl,weapon3)
		unsling(4,pl,weapon4)
		unsling(5,pl,weapon5)
		unsling(6,pl,weapon6)
	end
end)

function unsling(weapon,player,hash)
	local pedWeapon=hash
		Sling[weapon].Weapon = pedWeapon
		Wait(0)
		if DoesEntityExist(Sling[weapon].WeaponObject) then
			DeleteObject(Sling[weapon].WeaponObject)
			SetModelAsNoLongerNeeded(Sling[weapon].WeaponObject)
		end
		Sling[weapon].WeaponIsSlinged=false
end

function SlingWeapon(weapon,player,hash)
	if (weapon ~= 1 and weapon ~=2 and weapon ~= 3 and weapon ~=4 and weapon ~=5 and weapon ~=6) then return false end
	local pedWeapon=hash
	if Config.Weapons[""..pedWeapon] ~= nil and weapon==1 and Config.Weapons[""..pedWeapon]["allowone"] == false then return false end
	if Config.Weapons[""..pedWeapon] ~= nil and weapon==2 and Config.Weapons[""..pedWeapon]["allowtwo"] == false then return false end
	if Config.Weapons[""..pedWeapon] ~= nil and weapon==3 and Config.Weapons[""..pedWeapon]["allowthree"] == false then return false end
	if Config.Weapons[""..pedWeapon] ~= nil and weapon==4 and Config.Weapons[""..pedWeapon]["allowmelee"] == false then return false end
	if Config.Weapons[""..pedWeapon] ~= nil and weapon==5 and Config.Weapons[""..pedWeapon]["allowmelee2"] == false then return false end
	if Config.Weapons[""..pedWeapon] ~= nil and weapon==6 and Config.Weapons[""..pedWeapon]["allowmeleeback"] == false then return false end
	if Config.Weapons[""..pedWeapon] ~= nil and Sling[weapon].WeaponIsSlinged ~= true then
		Sling[weapon].Weapon = pedWeapon
		Wait(100)
		local objectName=GetHashKey(Config.Weapons[""..pedWeapon].objectName)
		RequestModel(objectName)
		while not HasModelLoaded(objectName) do
			Wait(100)
		end
		Sling[weapon].WeaponObject = CreateObject(objectName, 1.0, 1.0, 1.0, true, true, false)	
		if weapon == 1 then
		AttachEntityToEntity(Sling[weapon].WeaponObject, player, GetPedBoneIndex(player, 0xDEAD), 0.0, 0.0, -0.15, 90.0, 90.0, 0.0, 1, 1, 0, 1, 1, 0)
		elseif weapon == 4 or weapon == 5 then
		else
		AttachEntityToEntity(Sling[weapon].WeaponObject, player, GetPedBoneIndex(player, 0x8CBD), 0.0, 0.0, 0.0, 90.0, 270.0, 0.0, 1, 1, 0, 1, 1, 0)
		end
		Sling[weapon].WeaponIsSlinged=true
		if weapon == 1 then 
			weapon1 = hash
			AttachEntityToEntity(Sling[weapon].WeaponObject, player, GetPedBoneIndex(player, 24816), -0.09, 0.0, -0.23, 90.0, 20.0, 180.0, 1, 1, 0, 0, 2, 1)
		elseif weapon == 2 then
			weapon2 = hash
			unsling(3,pl, weapon3)
			--[[VELKE ZBRANE]]AttachEntityToEntity(Sling[weapon].WeaponObject, player, GetPedBoneIndex(player, 24816), 0.150, --[[+ > VEPREDU / - > VZADU]] -0.15, 0.05, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
		elseif weapon == 3 then
			weapon3 = hash
			unsling(2,pl, weapon2)
			AttachEntityToEntity(Sling[weapon].WeaponObject, player, GetPedBoneIndex(player, 24816), 0.4, -0.18, 0.1, 0.0, -20.0, 0.0, 1, 1, 0, 0, 2, 1)
		elseif weapon == 4 then 
			weapon4 = hash
			AttachEntityToEntity(Sling[weapon].WeaponObject, player, GetPedBoneIndex(player, 24816), -0.4, -0.1, 0.22, 90.0, -10.0, 120.0, 1, 1, 0, 0, 2, 1)
			unsling(5,pl, weapon5)
		elseif weapon == 5 then 
			weapon5 = hash
			AttachEntityToEntity(Sling[weapon].WeaponObject, player, GetPedBoneIndex(player, 24816), -0.05, 0.1, 0.22, -90.0, -10.0, 120.0, 1, 1, 0, 0, 2, 1)
			unsling(4,pl, weapon4)
		elseif weapon == 6 then 
			weapon6 = hash
			AttachEntityToEntity(Sling[weapon].WeaponObject, player, GetPedBoneIndex(player, 24816), -0.2, -0.18, 0.18, 0.0, 115.0, 0.0, 1, 1, 0, 0, 2, 1)
		end
	end
end

AddEventHandler('ox_inventory:currentWeapon', function(currentWeapon)
	if currentWeapon then
	weapon = currentWeapon.hash
	else
	weapon = false
	end
	if weapon then
		previousWeapon = weapon
	end
	if weapon == false then
		local pl = GetPlayerPed(-1)
		for k,v in pairs(Config.Weapons) do
			if tonumber(k) == previousWeapon then
				if Config.Weapons[""..tonumber(k)]["allowone"] and Sling[1].WeaponIsSlinged ~= true then
					SlingWeapon(1,pl, tonumber(k))
				end
				if Config.Weapons[""..tonumber(k)]["allowtwo"] and Sling[2].WeaponIsSlinged ~= true then
					SlingWeapon(2,pl, tonumber(k))
					unsling(3,pl, weapon3)
				end
				if Config.Weapons[""..tonumber(k)]["allowthree"] and Sling[3].WeaponIsSlinged ~= true then
					SlingWeapon(3,pl, tonumber(k))
					unsling(2,pl, weapon2)
				end
				if Config.Weapons[""..tonumber(k)]["allowmelee"] and Sling[4].WeaponIsSlinged ~= true then
					SlingWeapon(4,pl, tonumber(k))
					unsling(5,pl, weapon5)
				end
				if Config.Weapons[""..tonumber(k)]["allowmelee2"] and Sling[5].WeaponIsSlinged ~= true then
					SlingWeapon(5,pl, tonumber(k))
					unsling(4,pl, weapon4)
				end
				if Config.Weapons[""..tonumber(k)]["allowmelee3"] and Sling[6].WeaponIsSlinged ~= true then
					SlingWeapon(6,pl,tonumber(k))
				end
			end
		end
	else
		local pl = GetPlayerPed(-1)
		for k,v in pairs(Config.Weapons) do
			if tonumber(k) == previousWeapon then
				if Config.Weapons[""..tonumber(k)]["allowone"] and Sling[1].WeaponIsSlinged == true then
					unsling(1,pl, tonumber(k))
				end
				if Config.Weapons[""..tonumber(k)]["allowtwo"] and Sling[2].WeaponIsSlinged == true then
					unsling(2,pl, tonumber(k))
					unsling(3,pl, weapon3)
				end
				if Config.Weapons[""..tonumber(k)]["allowthree"] and Sling[3].WeaponIsSlinged == true then
					unsling(3,pl, tonumber(k))
					unsling(2,pl, weapon2)
				end
				if Config.Weapons[""..tonumber(k)]["allowmelee"] and Sling[4].WeaponIsSlinged == true then
					unsling(4,pl, tonumber(k))
					unsling(5,pl, weapon5)
				end
				if Config.Weapons[""..tonumber(k)]["allowmelee2"] and Sling[5].WeaponIsSlinged == true then
					unsling(5,pl, tonumber(k))
					unsling(4,pl, weapon4)
				end
				if Config.Weapons[""..tonumber(k)]["allowmelee3"] and Sling[6].WeaponIsSlinged == true then
					unsling(6,pl,tonumber(k))
				end
			end
		end
	
	end
end)