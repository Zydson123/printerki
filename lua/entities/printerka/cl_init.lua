include("shared.lua")

local imgui = include("imgui.lua") 

function ENT:Draw()
    


    self:DrawModel()

end
ENT.RenderGroup = RENDERGROUP_BOTH
local tier = 0;

function ENT:DrawTranslucent()
  -- While you can of course use the imgui.Start3D2D function for entities, IMGUI has some special syntax
  -- This function automatically calls LocalToWorld and LocalToWorldAngles respectively on position and angles 
  if imgui.Entity3D2D(self, Vector(0, 0, 0), Angle(180, 270, 0), 0.1) then
    -- render things
	draw.SimpleText(self:GetHajs().."$", imgui.xFont("!Roboto@50"), -100, -100, color_red)
    if imgui.xTextButton("Weź Pieniądze", "!Roboto@24", -100, -50, 200, 30, 1, Color(255,255,255), Color(0,0,255), Color(255,0,0)) then
      -- the xTextButton function returns true, if user clicked on this area during this frame
		print("Wyciągnięto pieniądze z drukarki z tierem: "..tier)
	--Zacznie to net message które wyśle impuls żeby hajs został zresetowany i przelany na twoje konto
	net.Start("nazwa")
	net.SendToServer()
    end
	draw.SimpleText(self:GetHajs().."$", imgui.xFont("!Roboto@50"), -100, -100, color_red)
    if imgui.xTextButton("Ulepsz szybkość "..tier, "!Roboto@24", -100, -10, 170, 30, 1, Color(255,255,255), Color(0,0,255), Color(255,0,0)) then
		net.Receive("upserwer", function(len)
        	tier =  net.ReadInt(16)
		end)
		net.Start("up")
			net.WriteInt(tier,16)
		net.SendToServer(tier)

		net.Receive("upserwer", function(len)
        	tier =  net.ReadInt(16)
		end)

		print("Ulepszono klient")
		print("Tier drukarki klient "..tier)
    end
    imgui.End3D2D()
  end
end