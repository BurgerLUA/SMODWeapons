if CLIENT then
	killicon.AddFont( "weapon_smod_m1grande", "ChatFont", "Grande Latte Macchiato", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/scout")
end

SWEP.Category				= "SMOD"
SWEP.PrintName				= "7.62MM M1 GRANDE"
SWEP.Base					= "weapon_cs_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 2750
SWEP.MoveSpeed				= 230

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 3
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/v_m1garand.mdl"
SWEP.WorldModel				= "models/weapons/w_m1garand.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "ar2"
SWEP.UseHands 				= false

--.30-06 Springfield

game.AddAmmoType({name = "smod_3006"})

if CLIENT then 
	language.Add("smod_3006_ammo",".30-06 Springfield")
end


SWEP.Primary.Damage			= 110
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("Weapon_Garand.Fire")
SWEP.Primary.Cone			= 0.00125
SWEP.Primary.ClipSize		= 8
SWEP.Primary.SpareClip		= 40
SWEP.Primary.Delay			= 1.2
SWEP.Primary.Ammo			= "smod_3006"
SWEP.Primary.Automatic 		= false

SWEP.RecoilMul				= 0.25
SWEP.SideRecoilMul			= 1
SWEP.VelConeMul				= 2
SWEP.HeatMul				= 0.25

SWEP.HasScope 				= false
SWEP.ZoomAmount 			= 1
SWEP.HasCrosshair 			= true
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= true
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= false
SWEP.HasDownRecoil			= false

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= true
SWEP.IronSightTime			= 0.25
SWEP.IronSightsPos 			= Vector(-4.97, 5, 2.6)
SWEP.IronSightsAng 			= Vector(0, 0.025, 0)

SWEP.DamageFalloff			= 5000

SWEP.DisableReloadUntilEmpty = true