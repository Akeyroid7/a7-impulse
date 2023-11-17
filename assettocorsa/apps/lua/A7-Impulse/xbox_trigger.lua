-- A7-Impulse Worker v0.0

-- Version ID of Custom Shaders Patch
-- 2651 - 0.2.00
-- 2144 - 0.1.79
-- 2051 - 0.1.78
-- 1937 - 0.1.77
--if ac.getPatchVersionCode() < 2651 then return end

local __gamepadIndex = ac.INIConfig.controlsConfig():get('X360', 'JOYPAD_INDEX', 0)

local TRIGGER_RUMBLE_INTENSITY = 0.1
local TRIGGER_RUMBLE_MIN = 0.1
local TRIGGER_RUMBLE_MAX_SLIP = 1000
local TRIGGER_RUMBLE_ABS = 0.5

local PRIORITY = -1

--------------------------------------------------------------------------------------------------------------------------------

local function weightedAverage(values, weights)
  if #values < 1 then error('There is no value.') end
  if #values ~= #weights then error('Number of elements does not match.') end
  local weightedValue = 0
  local totalWeight = 0
  for i, v in ipairs(values) do
    weightedValue = weightedValue + v * weights[i]
    totalWeight = totalWeight + weights[i]
  end
  if totalWeight == 0 then return 0 end
  return weightedValue / totalWeight
end

local function ellipseRadius(w, h, rad)
  return w * h / math.sqrt(w ^ 2 * math.sin(rad) ^ 2 + h ^ 2 * math.cos(rad) ^ 2)
end

--------------------------------------------------------------------------------------------------------------------------------

function script.update(dt)
  local status = 'inactive'
  local impulseL = 0
  local impulseR = 0
  local car = ac.getCar(0)
  if car then
    local wData = {}
    for i = 0, 3 do
      wData[i] = {}
      wData[i].fAngleRad = math.atan2(car.wheels[i].fy, car.wheels[i].fx)
    end

    local ndSlipB = (function(values, weights)
      for i = 0, 1 do
        values[i] = car.wheels[i].ndSlip * math.cos(wData[i].fAngleRad) * ellipseRadius(car.wheels[i].dx, car.wheels[i].dy, wData[i].fAngleRad) / car.wheels[i].dx
        weights[i] = car.wheels[i].load
      end
      return weightedAverage(values, weights) * math.sign(car.gear)
    end)({}, {})

    local ndSlipA = (function(values, weights)
      for i = 0, 3 do
        values[i] = car.wheels[i].ndSlip * -math.cos(wData[i].fAngleRad) * ellipseRadius(car.wheels[i].dx, car.wheels[i].dy, wData[i].fAngleRad) / car.wheels[i].dx
        weights[i] = car.wheels[i].load
      end
      return weightedAverage(values, weights) * math.sign(car.gear)
    end)({}, {})

    impulseL = math.min(1 < ndSlipB and (math.log(ndSlipB, TRIGGER_RUMBLE_MAX_SLIP) * (1 - TRIGGER_RUMBLE_MIN) + TRIGGER_RUMBLE_MIN) or 0 + (car.absInAction and TRIGGER_RUMBLE_ABS or 0), 1)
    impulseR = math.min(1 < ndSlipA and (math.log(ndSlipA, TRIGGER_RUMBLE_MAX_SLIP) * (1 - TRIGGER_RUMBLE_MIN) + TRIGGER_RUMBLE_MIN) or 0, 1)

    local xbox = ac.setXbox(__gamepadIndex, PRIORITY)
    if not car.isUserControlled then
      status = 'not user control (debug only)'
    elseif ac.getSim().inputMode ~= ac.UserInputMode.Gamepad then
      status = 'not gamepad mode (debug only)'
    elseif not xbox then
      status = 'impulse trigger is missing (debug only)'
    else
      status = 'active'
      xbox.triggerLeft = math.saturate(impulseL * TRIGGER_RUMBLE_INTENSITY)
      xbox.triggerRight = math.saturate(impulseR * TRIGGER_RUMBLE_INTENSITY)
    end
    ac.debug('absInAction', car.absInAction)
    ac.debug('isUserControlled', car.isUserControlled)
  end
  ac.debug('Impulse L', impulseL)
  ac.debug('Impulse R', impulseR)
  ac.debug('status', status)
end

--[[ Initial attempts
function script.update(dt)
  local car = ac.getCar(0)
  local xbox = ac.setXbox(__gamepadIndex, PRIORITY)
  local impulseL = 0
  local impulseR = 0
  if car and xbox then
    local ndSlipB = math.max(math.sign(car.gear) * math.cos(math.atan2(car.wheels[0].fy, car.wheels[0].fx)) * car.wheels[0].ndSlip,
                             math.sign(car.gear) * math.cos(math.atan2(car.wheels[1].fy, car.wheels[1].fx)) * car.wheels[1].ndSlip, 0)
    local ndSlipA
    if car.tractionType == 0 then -- 0 for rwd
      ndSlipA = math.max(math.sign(-car.gear) * math.cos(math.atan2(car.wheels[2].fy, car.wheels[2].fx)) * car.wheels[2].ndSlip,
                         math.sign(-car.gear) * math.cos(math.atan2(car.wheels[3].fy, car.wheels[3].fx)) * car.wheels[3].ndSlip, 0)
    elseif car.tractionType == 1 then -- 1 for fwd
      ndSlipA = math.max(math.sign(-car.gear) * math.cos(math.atan2(car.wheels[0].fy, car.wheels[0].fx)) * car.wheels[0].ndSlip,
                         math.sign(-car.gear) * math.cos(math.atan2(car.wheels[1].fy, car.wheels[1].fx)) * car.wheels[1].ndSlip, 0)
    else -- 2 for awd, 3 for new awd, -1 for N/A
      ndSlipA = math.max(math.sign(-car.gear) * math.cos(math.atan2(car.wheels[0].fy, car.wheels[0].fx)) * car.wheels[0].ndSlip,
                         math.sign(-car.gear) * math.cos(math.atan2(car.wheels[1].fy, car.wheels[1].fx)) * car.wheels[1].ndSlip,
                         math.sign(-car.gear) * math.cos(math.atan2(car.wheels[2].fy, car.wheels[2].fx)) * car.wheels[2].ndSlip,
                         math.sign(-car.gear) * math.cos(math.atan2(car.wheels[3].fy, car.wheels[3].fx)) * car.wheels[3].ndSlip, 0)
    end
    if 1 < ndSlipB then
      impulseL = math.min(TRIGGER_RUMBLE_MIN + math.log(ndSlipB, TRIGGER_RUMBLE_MAX_SLIP) * (1 - TRIGGER_RUMBLE_MIN), 1) * TRIGGER_RUMBLE_INTENSITY
    end
    if 1 < ndSlipA then
      impulseR = math.min(TRIGGER_RUMBLE_MIN + math.log(ndSlipA, TRIGGER_RUMBLE_MAX_SLIP) * (1 - TRIGGER_RUMBLE_MIN), 1) * TRIGGER_RUMBLE_INTENSITY
    end
    xbox.triggerLeft = impulseL
    xbox.triggerRight = impulseR
  end
  ac.debug('Impulse L', impulseL)
  ac.debug('Impulse R', impulseR)
end
]]
