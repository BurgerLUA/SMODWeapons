if CLIENT then
	killicon.Add( "vgui/killicons/smod_A35GL",	"/",	Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/killicons/smod_A35GL")
end

SWEP.Category				= "Extra Weapons"
SWEP.PrintName				= "GRENADE LAUNCHER"
SWEP.Base					= "weapon_cs_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 2000
SWEP.MoveSpeed				= 200

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 3
SWEP.SlotPos				= 2

SWEP.ViewModel				= "models/weapons/v_a35.mdl"
SWEP.WorldModel				= "models/weapons/w_a35.mdl"
SWEP.ViewModelFlip 			= true
SWEP.HoldType				= "ar2"

game.AddAmmoType({name = "ex_launcher"})

if CLIENT then 
	language.Add("ex_launcher_ammo","20MM HE")
end

SWEP.Primary.Damage			= 48
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("weapons/ar2/npc_ar2_altfire.wav")
SWEP.Primary.Cone			= 0.25
SWEP.Primary.ClipSize		= 6
SWEP.Primary.SpareClip		= 6
SWEP.Primary.Delay			= 0.75
SWEP.Primary.Ammo			= "ex_launcher"
SWEP.Primary.Automatic 		= false

SWEP.RecoilMul 				= 1
SWEP.SideRecoilMul			= 1
SWEP.VelConeMul				= 0
SWEP.HeatMul				= 1

SWEP.HasScope 				= true
SWEP.ZoomAmount				= 0.5
SWEP.HasCrosshair 			= false
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= true
SWEP.HasBoltAction			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false 
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= false
SWEP.HasDownRecoil			= false
SWEP.HasDual				= false

SWEP.HasIronSights 			= false
SWEP.EnableIronCross		= false
SWEP.HasGoodSights			= false
SWEP.IronSightTime			= 0.25
SWEP.IronSightsPos 			= Vector(2, 0, 1)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.DamageFalloff			= 100

SWEP.Object					= "grenade_ar2"

SWEP.AddFOV					= 10

SWEP.HasHL2Pump				= true

SWEP.PumpSound				= Sound("weapons/shotgun/shotgun_cock.wav")

function SWEP:PrimaryAttack()


	if not self:CanPrimaryAttack() then	return end
	if not self:CanShoot() then return end
	self:TakePrimaryAmmo(1)

	self:WeaponSound()
	self:WeaponDelay() -- don't predict, has delay
	self:WeaponAnimation(self:Clip1(),ACT_VM_PRIMARYATTACK)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	if (IsFirstTimePredicted() or game.SinglePlayer()) then
			
		if SERVER then
			local Shoot = self.Owner:GetShootPos()
			local Eye= self.Owner:EyeAngles()
			self:ThrowObject(self.Object,2000)
		end

		if (CLIENT or game.SinglePlayer()) then 
			self:AddRecoil() -- Predict
		end

	end

end

function SWEP:ThrowObject(object,force)

	if (CLIENT) then return end
	local EA =  self.Owner:EyeAngles()
	local pos = self.Owner:GetShootPos() + EA:Right() * 2 - EA:Up() * 4 + EA:Forward() * 10	

	local ent = ents.Create(object)		
	ent:SetPos(pos)
	ent:SetAngles(EA)
	ent:Spawn()
	ent:Activate()
	ent:Fire()
	ent:SetOwner(self.Owner)
	
	if ent:GetPhysicsObject():IsValid() then
		if object == "ent_cs_gasparticle" then
			ent:GetPhysicsObject():SetVelocity( EA:Forward()*force + EA:Right()*math.random(-20,20) + EA:Up()*math.random(-20,20) + Vector(0,0,-10) )
		else
			ent:GetPhysicsObject():SetVelocity(self.Owner:GetVelocity() + EA:Forward() * force + EA:Up()*50)
		end
	else
		ent:SetVelocity(self.Owner:GetVelocity() + EA:Forward() * force)
	end
	
	ent.Damage = 100
	ent.Radius = 100
	
end
