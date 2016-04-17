ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "MAG NADE"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.BounceSound = Sound("HEGrenade.Bounce")
ENT.ExplodeSound = Sound("BaseGrenade.Explode")
ENT.DebrisSound = Sound("BaseExplosionEffect.Sound")

AddCSLuaFile()

function ENT:Initialize()
	if SERVER then
		self:SetModel("models/weapons/w_eq_fraggrenade.mdl") 
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
			phys:SetBuoyancyRatio(0)
		end
		
		self.Delay = CurTime() + 2
	end
end

function ENT:PhysicsCollide(data, physobj)

	if SERVER then
	
		if self:GetVelocity():Length() > 50 then
		
			self:EmitSound(self.BounceSound)
			
			if self:GetVelocity():Length() > 100 then
				if data.HitEntity and data.HitEntity:Health() then

					local dmginfo = DamageInfo()
					
					dmginfo:SetDamage(10)
					dmginfo:SetAttacker(self.Owner or self)
					dmginfo:SetInflictor(self)
					dmginfo:SetDamageType(DMG_CRUSH)
				
					data.HitEntity:TakeDamageInfo(dmginfo)
					
				end
			end

		end

	end
	
end

function ENT:Think()
	if SERVER then
		if CurTime() > self.Delay then 
			self:Detonate(self,self:GetPos())
		end
	end
end

function ENT:Detonate(self,pos)
	if SERVER then
		if not self:IsValid() then return end
		
		local effectdata = EffectData()
			effectdata:SetStart( pos + Vector(0,0,100)) // not sure if we need a start and origin (endpoint) for this effect, but whatever
			effectdata:SetOrigin( pos)
			effectdata:SetScale( 100 )
			effectdata:SetRadius( 5000 )
		util.Effect( "Explosion", effectdata)

		if self.Owner then
			util.BlastDamage(self, self.Owner, pos, math.floor( GetConVar("sv_css_he_radius"):GetFloat() ), math.floor( GetConVar("sv_css_he_damage"):GetFloat() ) )
		end
		
		self:EmitSound(self.ExplodeSound)
		
		if IsValid(self.HitP) then
			self.Pos1 = self.HitP + self.HitN
			self.Pos2 = self.HitP - self.HitN
			util.Decal("Scorch", self.Pos1, self.Pos2)
		end
				
		self:Remove()
	end
end

function ENT:Draw()
	if CLIENT then
		self:DrawModel()
	end
end


