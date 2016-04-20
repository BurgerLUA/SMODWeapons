if CLIENT then
	killicon.AddFont( "weapon_cs_crowbar",		"HL2MPTypeDeath",	"6",	Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/achievements/pistol_round_knife_kill")
end

SWEP.Category				= "Extra Weapons"
SWEP.PrintName				= "FISTS"
SWEP.Base					= "weapon_cs_base"
SWEP.WeaponType				= "Free"

SWEP.Cost					= 0
SWEP.MoveSpeed				= 250

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 0
SWEP.SlotPos				= 1

SWEP.ViewModel 				= Model( "models/weapons/c_arms.mdl" )
SWEP.WorldModel				= ""
SWEP.VModelFlip 			= false
SWEP.HoldType				= "fist"

SWEP.Primary.Damage			= 40
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= -1
SWEP.Primary.SpareClip		= -1
SWEP.Primary.Delay			= 1/(180/60)
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Automatic 		= true 

SWEP.Secondary.Damage		= 80
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.SpareClip	= -1
SWEP.Secondary.Delay		= 1/(60/60)
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

SWEP.MeleeSoundMiss			= Sound( "WeaponFrag.Throw" )
SWEP.MeleeSoundWallHit		= Sound( "Flesh.ImpactHard" )
SWEP.MeleeSoundFleshSmall	= Sound( "Flesh.ImpactHard" )
SWEP.MeleeSoundFleshLarge	= Sound( "Flesh.ImpactHard" )

function SWEP:PrimaryAttack()

	if self:IsUsing() then return end
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	if self:GetIsLeftFire() then
		self:SendSequence("fists_left")
		self:SetIsLeftFire(false)
	else
		self:SendSequence("fists_right")
		self:SetIsLeftFire(true)
	end

	if self:NewSwing(self.Primary.Damage) then
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
	else
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay*2)
		self:SetNextSecondaryFire(CurTime() + self.Primary.Delay*2)
	end
	
end

function SWEP:SendSequence(anim)
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( anim ) )
end

function SWEP:SecondaryAttack()

	if self:IsUsing() then return end
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_uppercut" ) )

	if self:NewSwing(self.Primary.Damage * 2 ) then
		self:SetNextPrimaryFire(CurTime() + self.Secondary.Delay)
		self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
	else
		self:SetNextPrimaryFire(CurTime() + self.Secondary.Delay*2 )
		self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay*2 )
	end
	
end

function SWEP:Reload()
	--PrintTable(GetActivities(self))
	--PrintTable(self:GetSequenceList())
end

function SWEP:Deploy()
	self.Owner:DrawViewModel(true)
	self:SendSequence("fists_draw")
	self:SetNextPrimaryFire(CurTime() + self.Owner:GetViewModel():SequenceDuration())	
	return true
end