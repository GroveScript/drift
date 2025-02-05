local default
local drift = {
    ["mass"] = 100000,
    ["turnMass"] = 300000,
    ["dragCoeff"] = 0,
    ["centerOfMass"] = { 0, -0.15, -0.55 },
    ["percentSubmerged"] = 70,
    ["tractionMultiplier"] = 0.7,
    ["tractionLoss"] = 0.8,
    ["tractionBias"] = 0.45,
    ["numberOfGears"] = 5,
    ["engineAcceleration"] = 565,
    ["engineInertia"] = -272,
    ["driveType"] = "rwd",
    ["engineType"] = "electric",
    ["brakeDeceleration"] = 100000,
    ["brakeBias"] = 0.1,
    ["ABS"] = false,
    ["steeringLock"] = 79,
    ["seatOffsetDistance"] = 0.15,
    ["collisionDamageMultiplier"] = 0,
    ["monetary"] = 35000,
    ["modelFlags"] = 0x40000000,
    ["handlingFlags"] = 0x10400000,
    ["headLight"] = 0,
    ["tailLight"] = 1,
    ["animGroup"] = 0,
}

local function setDefault(vehicle)
  if isElement(vehicle) and type(default) == "table" then
      for key,value in pairs(default) do setVehicleHandling(vehicle, key, value) end
      default = nil
      return true
  end
  return false
end

local function setDrift(vehicle)
  local model = isElement(vehicle) and vehicle:getModel()
  if CONFIG.vehicle[model] then
      default = getVehicleHandling(vehicle)
      for key,value in pairs(drift) do setVehicleHandling(vehicle, key, value) end
      return true
  end
  return false
end

bindKey(CONFIG.bindKey, "down", function()
  local vehicle = getPedOccupiedVehicle(localPlayer)
  return vehicle and (default and setDefault(vehicle) or setDrift(vehicle))
end)

addEventHandler("onClientPlayerVehicleExit", getRootElement(), setDefault)
