-- A7-Impulse Loader v0.0

local status

if type(physics) == "table" and type(physics.startPhysicsWorker) == "function" then
  physics.startPhysicsWorker('xbox_trigger', nil, error)
  status = 'active'
else
  status = 'not available'
end

function script.update(dt)
  ac.debug('status', status)
end
