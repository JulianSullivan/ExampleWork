--[[ PROPERTY(SoundEvent) ]]--
TouchSound = "None"

--[[ PROPERTY(Cog) ]]--
Target = "None"

ResetX = 0
ResetY = 0

FirstFrame = true

Activated = false

Player = "None"

function Initialize()
  Space:ConnectLogicUpdate (Update)
end 


function Update(updateEvent)
  if (FirstFrame) then
    local thing = Owner.Transform.Translation;
    ResetX = thing.X
    ResetY = thing.Y
    Player = Space:FindChild(Target)
    FirstFrame = false
  end

  --if (TargetIsInside()) then Aubergine:PushUserMessage("INSDIE") end
  --if (not Activated) then Aubergine:PushUserMessage("ACTIVATED") end
  --if (Target ~= "None") then Aubergine:PushUserMessage("TARGET") end
  
  if (not Activated and Target ~= "None" and TargetIsInside()) then
    Player:GetComponent("ResetComponent").ResetX = ResetX
    Player:GetComponent("ResetComponent").ResetY = ResetY
    Activated = true
  end
end


function TargetIsInside()
  local playerPos = Player.Transform.Translation
  local myPos = Owner.Transform.Translation
  local myScale = Owner.Transform.Scale
  local minX = myPos.X - (myScale.X / 2)
  local minY = myPos.Y - (myScale.Y / 2)
  local maxX = myPos.X + (myScale.X / 2)
  local maxY = myPos.Y + (myScale.Y / 2)

  return not (playerPos.X < minX or 
              playerPos.X > maxX or
              playerPos.Y < minY or
              playerPos.Y > maxY)
  
end

function Destroy(event)
	Space:DisconnectLogicUpdate(Update)
end
