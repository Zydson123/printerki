ENT.type = 'anim'
ENT.Base = "base_gmodentity"

ENT.PrintName = "Printerka ale lepsza"

ENT.Spawnable = true

function ENT:SetupDataTables()
    self:NetworkVar("String", 1, "Wlasciciel")
    self:NetworkVar("Int", 1, "Hajs")
end
