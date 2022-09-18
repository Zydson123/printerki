AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("imgui.lua")
util.AddNetworkString("nazwa")
util.AddNetworkString("up")
util.AddNetworkString("upserwer")

local imgui = include("imgui.lua") 
include("shared.lua")

local interval = 1
local tier = 0

function ENT:Initialize()

    self:SetModel("models/props_c17/consolebox03a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetColor(color_black)
    --self:SetMaterial("models/debug/debugwhite")

    --CurTime() - ile serwer jest już działający (w sekundach)

    self.timer = CurTime() --self.timer przechowa czas wtedy kiedy entity powstało

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
       
        phys:Wake()
         
    end
    if ( IsValid( ent ) ) then

		ent:Spawn()
		ent:SetOwner( self.Owner )
        self:SetWlasciciel(ent:GetOwner())

	end
end

function ENT:Think()

    if CurTime() > self.timer + interval then
    --if będzie działał tak że odpalać się będzie co wartośc zmiennej "interval"
        
        self.timer = CurTime()

        self:SetHajs(self:GetHajs() + 100)

    end
    net.Receive("nazwa", function(len,ply)

        --ply:Kill()
        local forsa = self:GetHajs()
        self:SetHajs(0)
        ply:addMoney(forsa)

    end)

    net.Receive("up", function(len,ply)

        tier =  net.ReadInt(16)
        tier = tier + 1

        if tier <= 5 then
        interval = interval -0.07 
        end

        print("Tier drukarki serwer "..tier.." Nowy interval to: "..interval)        


        if tier >= 6 then
            interval = 0.65
            tier = 5
        end

        net.Start("upserwer")
            net.WriteInt(tier,16)
        net.Send(ply)
    end)

end



--function ENT:Use(a,c)

    --local forsa = self:GetHajs()
    --self:SetHajs(0)
    --c:addMoney(forsa)
    
--end