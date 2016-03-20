if CLIENT then
	killicon.AddFont( "weapon_smod_oicw", "ChatFont", "OICW", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/ak47")
end

SWEP.Category				= "SMOD"
SWEP.PrintName				= "5.56MM OICW"
SWEP.Base					= "weapon_cs_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 2500
SWEP.MoveSpeed				= 221

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 3
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/v_oicw.mdl"
SWEP.WorldModel				= "models/weapons/w_oicw.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "ar2"

SWEP.Primary.Damage			= 30
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("Weapon_OICW.Single")
SWEP.Primary.Cone			= 0.0075
SWEP.Primary.ClipSize		= 30
SWEP.Primary.SpareClip		= 90
SWEP.Primary.Delay			= 1/(800/60)
SWEP.Primary.Ammo			= "AirboatGun"
SWEP.Primary.Automatic 		= true

SWEP.RecoilMul				= 1
SWEP.SideRecoilMul			= 0.5
SWEP.VelConeMul				= 2
SWEP.HeatMul				= 1

SWEP.HasScope 				= true
SWEP.ZoomAmount 			= 4
SWEP.HasCrosshair 			= true
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= true
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= true
SWEP.HasDownRecoil			= false
SWEP.HasSpecialFire			= true

SWEP.BurstOverride			= 3
SWEP.BurstConeMul			= 1
SWEP.BurstSpeedOverride 	= 1
SWEP.BurstRecoilMul			= 0.5
SWEP.BurstHeatMul			= 0.5

SWEP.HasIronSights 			= false
SWEP.EnableIronCross		= false
SWEP.HasGoodSights			= false
SWEP.IronSightTime			= 0.125
SWEP.IronSightsPos 			= Vector(-3, 20, 0)
SWEP.IronSightsAng 			= Vector(1.25, 1, 0)

SWEP.DamageFalloff			= 4000

function SWEP:SpecialFire()

	if not self:CanPrimaryAttack() then	return end
	if self:IsBusy() then return end
	if self:GetNextPrimaryFire() > CurTime() then return end
	
	
	--if not self:CanShoot() then return end
	
	if self:Clip1() < 10 then return end
	self:TakePrimaryAmmo(10)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self:WeaponAnimation(self:Clip1(),ACT_VM_SECONDARYATTACK)

	if (IsFirstTimePredicted() or game.SinglePlayer()) then
		if (CLIENT or game.SinglePlayer()) then 
			self:AddRecoil() -- Predict
		end

		local Damage = self.Primary.Damage*10
		local Shots = 1
		local Cone = self:HandleCone(0)
		local Source = self.Owner:GetShootPos()
		local Direction = self.Owner:GetAimVector()
		
		if self.Owner:IsPlayer() then
			Direction = (self.Owner:EyeAngles() + self.Owner:GetPunchAngle()):Forward()
		end
		
		self:EmitGunSound("beta/fire1.wav")
		
		self:ShootBullet(Damage,Shots,Cone,Source,Direction,self.EnableTracer)
		self:AddHeat(Damage,Shots)
	end
	
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay*10*2)
	
end