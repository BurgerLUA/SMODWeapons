if CLIENT then
	killicon.Add( "weapon_smod_m4a1", "vgui/killicons/smod_m4a1", Color( 0, 128, 255, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/killicons/smod_m4a1")
end

SWEP.Category				= "SMOD"
SWEP.PrintName				= "5.56MM MARKSMAN M4A1"
SWEP.Base					= "weapon_cs_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 2500
SWEP.MoveSpeed				= 221

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 3
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/v_m4a1.mdl"
SWEP.WorldModel				= "models/weapons/w_m4a1.mdl"
SWEP.ViewModelFlip 			= true
SWEP.HoldType				= "ar2"

SWEP.Primary.Damage			= 30
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("weapons/m4a1/m4sil-1.wav")
SWEP.Primary.Cone			= 0.00125
SWEP.Primary.ClipSize		= 30
SWEP.Primary.SpareClip		= 90
SWEP.Primary.Delay			= 1/10
SWEP.Primary.Ammo			= "AirboatGun"
SWEP.Primary.Automatic 		= false

SWEP.RecoilMul				= 1
SWEP.SideRecoilMul			= 0.5
SWEP.VelConeMul				= 2
SWEP.HeatMul				= 1

SWEP.HasScope 				= false
SWEP.ZoomAmount 			= 1
SWEP.HasCrosshair 			= true
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= true
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= true
SWEP.HasDownRecoil			= false

SWEP.BurstOverride			= 3
SWEP.BurstConeMul			= 1
SWEP.BurstSpeedOverride 	= 1.5
SWEP.BurstRecoilMul			= 0.25
SWEP.BurstHeatMul			= 0.25

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= true
SWEP.IronSightTime			= 0.125
SWEP.IronSightsPos 			= Vector(0, 0, 1)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.DamageFalloff			= 2000
