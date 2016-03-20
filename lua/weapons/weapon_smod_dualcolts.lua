if CLIENT then
	killicon.AddFont( "weapon_smod_dualcolts", "ChatFont", "AMURICA", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/gfx/vgui/ump45")
end

SWEP.Category				= "SMOD"
SWEP.PrintName				= ".45ACP COLT AKIMBO"
SWEP.Base					= "weapon_cs_base"
SWEP.WeaponType				= "Secondary"

SWEP.Cost					= 1500
SWEP.MoveSpeed				= 200


SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 1
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/v_colts.mdl"
SWEP.WorldModel				= "models/weapons/w_colts.mdl"
SWEP.ViewModelFlip 			= false
SWEP.HoldType				= "duel"
SWEP.UseHands				= false

SWEP.Primary.Damage			= 50
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("weapons/colts/fire.wav")
SWEP.Primary.Cone			= 0.01
SWEP.Primary.ClipSize		= 14
SWEP.Primary.SpareClip		= 14*4
SWEP.Primary.Delay			= 1/7
SWEP.Primary.Ammo			= "SniperPenetratedRound"
SWEP.Primary.Automatic 		= false

SWEP.EnableTracer			= false

SWEP.RecoilMul				= 1
SWEP.SideRecoilMul			= 0.1
SWEP.VelConeMul				= 1
SWEP.HeatMul				= 0.5

SWEP.HasScope 				= false
SWEP.ZoomAmount 			= 0.5
SWEP.HasCrosshair 			= true
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= true
SWEP.HasDownRecoil			= false
SWEP.HasDual				= true

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= true
SWEP.IronSightTime			= 0.125
SWEP.IronSightsPos 			= Vector(0, 0, 2)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.DamageFalloff			= 1000