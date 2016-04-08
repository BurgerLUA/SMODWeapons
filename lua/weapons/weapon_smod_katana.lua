if CLIENT then
	killicon.Add( "weapon_smod_katana", "vgui/killicons/smod_Sword", Color( 0, 128, 255, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/killicons/smod_Sword")
end

SWEP.Category				= "SMOD"
SWEP.PrintName				= "SWORD OF THE WEEBS"
SWEP.Base					= "weapon_cs_base"
SWEP.WeaponType				= "Free"

SWEP.Cost					= 0
SWEP.MoveSpeed				= 250

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 0
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/v_sword.mdl"
SWEP.WorldModel				= "models/weapons/w_sword.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "melee2"

game.AddAmmoType({name = "smod_weeb"})

if CLIENT then 
	language.Add("smod_weeb_ammo","Weeb")
end

SWEP.Primary.Damage			= 75
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 100
SWEP.Primary.SpareClip		= 0
SWEP.Primary.Delay			= 0.4
SWEP.Primary.Ammo			= "smod_weeb"
SWEP.Primary.Automatic 		= true 

SWEP.Secondary.Damage		= 100
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.SpareClip	= -1
SWEP.Secondary.Delay		= 1
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.Automatic 	= true 

SWEP.RecoilMul				= 1
SWEP.HasScope 				= false
SWEP.ZoomAmount 			= 1
SWEP.HasCrosshair 			= false
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= false

SWEP.MeleeSoundMiss			= Sound("Weapon_SMODSword.Slash")
SWEP.MeleeSoundWallHit		= Sound("Weapon_SMODSword.HitWall")
SWEP.MeleeSoundFleshSmall	= Sound("Weapon_SMODSword.Hit")
SWEP.MeleeSoundFleshLarge	= Sound("Weapon_SMODSword.Stab")

SWEP.DamageFalloff			= 40

function SWEP:PrimaryAttack()
	if self:IsUsing() then return end
	if self:GetNextPrimaryFire() > CurTime() then return end
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self:SendWeaponAnim(ACT_VM_HITCENTER)
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
	if self:Swing(self.Primary.Damage) then
		self:AddDurability(-math.random(1,3))
	end
end


function SWEP:SecondaryAttack()
	if self:IsUsing() then return end
	if self:GetNextSecondaryFire() > CurTime() then return end
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self:SendWeaponAnim(ACT_VM_HITKILL)
	self:SetNextPrimaryFire(CurTime() + self.Secondary.Delay)
	self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
	if self:Swing(self.Secondary.Damage) then
		self:AddDurability(-math.random(5,8))
	end
end

function SWEP:Reload()

end

function SWEP:AddDurability(amount)

	self:SetClip1( math.Clamp(self:Clip1() + amount,0,100) )

	if self:Clip1() <= 0 then
		self.Owner:EmitSound(Sound("AlyxEMP.Discharge"))
		self.Owner:StripWeapon(self.Weapon:GetClass())
	end
	
	--[[
	self.Owner:SetAmmo( math.Clamp(self.Owner:GetAmmoCount(self.Primary.Ammo) + amount,0,100),self.Primary.Ammo)
	if self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then
		self.Owner:EmitSound(Sound("AlyxEMP.Discharge"))
		self.Owner:StripWeapon(self.Weapon:GetClass())
	end
	--]]
end

function SWEP:Deploy()

	self:EmitGunSound(Sound("Weapon_SMODSword.Deploy"))
	self.Owner:DrawViewModel(true)
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime() + self.Owner:GetViewModel():SequenceDuration())	
	
	return true
end

function GetActivities( ent )
  local k, v, t

  t = { }

  for k, v in ipairs( ent:GetSequenceList( ) ) do
    table.insert( t, { id = k, act = ent:GetSequenceActivity( k ), actname = ent:GetSequenceActivityName( k ) } )
  end

  return t
end


function SWEP:BlockDamage(Damage)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self:SendWeaponAnim(ACT_VM_HITCENTER)
	self:EmitGunSound(self.MeleeSoundMiss)
	self.Owner:EmitSound(Sound("FX_RicochetSound.Ricochet"))
	self:SetNextPrimaryFire(CurTime() + 1)
	self:SetNextSecondaryFire(CurTime() + 1)
	self:AddDurability(- math.ceil(Damage*0.1) )
end

function KATANA_ScalePlayerDamage(victim,hitgroup,dmginfo)

	local attacker = dmginfo:GetAttacker()
	local Weapon = victim:GetActiveWeapon()

	if Weapon and Weapon ~= NULL and Weapon:GetClass() == "weapon_smod_katana" then
		if victim:KeyDown(IN_RELOAD) then
		
			local VictimAngles = victim:GetAngles() + Angle(0,180,0)
			local AttackerAngles = attacker:GetAngles()
			
			VictimAngles:Normalize()
			AttackerAngles:Normalize()
			
			local NewAngles = VictimAngles - AttackerAngles
			
			NewAngles:Normalize()
			
			local Yaw = math.abs(NewAngles.y)
			
			if Yaw < 30 then

				local Damage = dmginfo:GetDamage()
				
				--print(Damage)
				
				if Damage/2 > 10 then
					Weapon:ShootBullet(Damage / 2, 1, 0.01, victim:GetShootPos(), victim:GetAimVector(), true)
				end
				
				Weapon:BlockDamage(Damage)

				
				
				
				if CLIENT then
					return true
				else
					return true
				end
				
			end
			
		end
	end

end

hook.Add("ScalePlayerDamage","KATANA_ScalePlayerDamage",KATANA_ScalePlayerDamage)






