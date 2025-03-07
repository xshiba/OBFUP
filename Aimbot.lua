local mt = getrawmetatable(game)
setreadonly(mt,false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(...)
    local method = getnamecallmethod()
    local args = {...}
    if not (Options.AimbotSkill.Value) and
    not (Options.AutoFarmPlayer.Value) and
    not (Options.AutoFarmBounty.Value) and
    not UseSkill and
    not USEGUN and
    not (Options.AutoFarmSeaEvents.Value) and
    not (Options.AutoFinishTrail.Value) and
    not (Options.AutoFarmSeaBeasts.Value) then
        return old(unpack(args))
    end
    if Dontaim then
        return old(unpack(args))
    end
    if tostring(method) == "FireServer" then
        if tostring(args[1]) == "RemoteEvent" then
            if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
                if Options.AimbotSkill.Value and _G.TargetPlayerAim ~= nil then
                    if _G.TargetPlayerAim ~= nil then
                        if tostring(typeof(args[2])) == "CFrame" then
                            args[2] = _G.TargetPlayerAim
                        elseif tostring(typeof(args[2])) == "Vector3" then
                            args[2] = _G.TargetPlayerAim.Position
                        end
                        return old(unpack(args))
                    end
                end
                if Options.AutoFarmPlayer.Value and PosCharacter ~= nil then
                    if PosCharacter ~= nil then
                        if tostring(typeof(args[2])) == "CFrame" then
                            args[2] = PosCharacter
                        elseif tostring(typeof(args[2])) == "Vector3" then
                            args[2] = PosCharacter.Position
                        end
                        return old(unpack(args))
                    end
                end
                if UseSkill then
                    if PosMonMasteryFruit ~= nil and (Options.AutoFarmFruitsMastery.Value or Options.AutoRelicEvents.Value or Options.AutoDragonHunter.Value or Options.AutoFarmBoneMasteryFruits.Value or Options.AutoFarmCakePiratesMasteryFruits.Value) then
                        if tostring(typeof(args[2])) == "CFrame" then
                            args[2] = PosMonMasteryFruit
                        elseif tostring(typeof(args[2])) == "Vector3" then
                            args[2] = PosMonMasteryFruit.Position
                        end
                        return old(unpack(args))
                    end
                end
                if USEGUN then
                    if PosMonMasteryGun ~= nil and (Options.AutoFarmGunMastery.Value or Options.AutoFarmBoneMasteryGun.Value) then
                        if tostring(typeof(args[2])) == "CFrame" then
                            args[2] = PosMonMasteryGun
                        elseif tostring(typeof(args[2])) == "Vector3" then
                            args[2] = PosMonMasteryGun.Position
                        end
                        return old(unpack(args))
                    end
                end
                if SeaEventsEnabled and Options.AutoFarmSeaEvents.Value then
                    if SeaEventsPos ~= nil and Options.AutoFarmSeaEvents.Value then
                        if tostring(typeof(args[2])) == "CFrame" then
                            args[2] = SeaEventsPos
                        elseif tostring(typeof(args[2])) == "Vector3" then
                            args[2] = SeaEventsPos.Position
                        end
                        return old(unpack(args))
                    end
                end
                if FindShip and Options.AutoFarmSeaEvents.Value then
                    if ShipPos ~= nil and Options.AutoFarmSeaEvents.Value then
                        if tostring(typeof(args[2])) == "CFrame" then
                            args[2] = ShipPos
                        elseif tostring(typeof(args[2])) == "Vector3" then
                            args[2] = ShipPos.Position
                        end
                        return old(unpack(args))
                    end
                end
                if StartSub and Options.AutoCompleteTrial.Value then
                    if SeaBeastPos ~= nil and Options.AutoCompleteTrial.Value then
                        if tostring(typeof(args[2])) == "CFrame" then
                            args[2] = SeaBeastPos
                        elseif tostring(typeof(args[2])) == "Vector3" then
                            args[2] = SeaBeastPos.Position
                        end
                        return old(unpack(args))
                    end
                end
                if FindSeabeast and Options.AutoFarmSeaBeasts.Value then
                    if SeaBeastPos ~= nil and Options.AutoFarmSeaBeasts.Value then
                        if tostring(typeof(args[2])) == "CFrame" then
                            args[2] = SeaBeastPos
                        elseif tostring(typeof(args[2])) == "Vector3" then
                            args[2] = SeaBeastPos.Position
                        end
                        return old(unpack(args))
                    end
                end
            end
        end
    elseif tostring(method) == "InvokeServer" then
        if tostring(args[1]) == "" then
            if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
                if Options.AimbotSkill.Value and _G.TargetPlayerAim ~= nil then
                    if _G.TargetPlayerAim ~= nil then
                        if tostring(typeof(args[3])) == "CFrame" then
                            args[3] = _G.TargetPlayerAim
                        elseif tostring(typeof(args[3])) == "Vector3" then
                            args[3] = _G.TargetPlayerAim.Position
                        end
                        return old(unpack(args))
                    end
                end
                if Options.AutoFarmPlayer.Value and PosCharacter ~= nil then
                    if PosCharacter ~= nil then
                        if tostring(typeof(args[3])) == "CFrame" then
                            args[3] = PosCharacter
                        elseif tostring(typeof(args[3])) == "Vector3" then
                            args[3] = PosCharacter.Position
                        end
                        return old(unpack(args))
                    end
                end
                if Options.AutoFarmBounty.Value and PosCharacterBounty ~= nil then
                    if PosCharacterBounty ~= nil then
                        if tostring(typeof(args[3])) == "CFrame" then
                            args[3] = PosCharacterBounty
                        elseif tostring(typeof(args[3])) == "Vector3" then
                            args[3] = PosCharacterBounty.Position
                        end
                        return old(unpack(args))
                    end
                end
                if UseSkill then
                    if PosMonMasteryFruit ~= nil and (Options.AutoFarmFruitsMastery.Value or Options.AutoFarmBoneMasteryFruits.Value or Options.AutoFarmCakePiratesMasteryGun.Value) then
                        if tostring(typeof(args[3])) == "CFrame" then
                            args[3] = PosMonMasteryFruit
                        elseif tostring(typeof(args[3])) == "Vector3" then
                            args[3] = PosMonMasteryFruit.Position
                        end
                        return old(unpack(args))
                    end
                end
                if USEGUN then
                    if PosMonMasteryGun ~= nil and (Options.AutoFarmGunMastery.Value or Options.AutoFarmBoneMasteryGun.Value) then
                        if tostring(typeof(args[3])) == "CFrame" then
                            args[3] = PosMonMasteryGun
                        elseif tostring(typeof(args[3])) == "Vector3" then
                            args[3] = PosMonMasteryGun.Position
                        end
                        return old(unpack(args))
                    end
                end
                if SeaEventsEnabled and Options.AutoFarmSeaEvents.Value then
                    if SeaEventsPos ~= nil and Options.AutoFarmSeaEvents.Value then
                        if tostring(typeof(args[3])) == "CFrame" then
                            args[3] = SeaEventsPos
                        elseif tostring(typeof(args[3])) == "Vector3" then
                            args[3] = SeaEventsPos.Position
                        end
                        return old(unpack(args))
                    end
                end
                if FindShip and Options.AutoFarmSeaEvents.Value then
                    if ShipPos ~= nil and Options.AutoFarmSeaEvents.Value then
                        if tostring(typeof(args[3])) == "CFrame" then
                            args[3] = ShipPos
                        elseif tostring(typeof(args[3])) == "Vector3" then
                            args[3] = ShipPos.Position
                        end
                        return old(unpack(args))
                    end
                end
                if StartSub and Options.AutoCompleteTrial.Value then
                    if SeaBeastPos ~= nil and Options.AutoCompleteTrial.Value then
                        if tostring(typeof(args[3])) == "CFrame" then
                            args[3] = SeaBeastPos
                        elseif tostring(typeof(args[3])) == "Vector3" then
                            args[3] = SeaBeastPos.Position
                        end
                        return old(unpack(args))
                    end
                end
                if FindSeabeast and Options.AutoFarmSeaBeasts.Value then
                    if SeaBeastPos ~= nil and Options.AutoFarmSeaBeasts.Value then
                        if tostring(typeof(args[3])) == "CFrame" then
                            args[3] = SeaBeastPos
                        elseif tostring(typeof(args[3])) == "Vector3" then
                            args[3] = SeaBeastPos.Position
                        end
                        return old(unpack(args))
                    end
                end
            end
        end
    end 
    return old(...)
end)
