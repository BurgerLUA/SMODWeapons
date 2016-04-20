function SMOD_MovementStuff()
	--[[
	for n,ply in pairs(player.GetAll()) do
	
		local Value = 0

		for k,v in pairs(ents.FindByClass("ent_smod_magnade")) do
			if ply:GetPos():Distance(v:GetPos()) < 500 and v:GetNWBool("Detonated",false) then
				Value = Value + 1
			end
		end

		if Value > 0 then
			ply:SetLaggedMovementValue( 0.25 )
		else
			ply:SetLaggedMovementValue( 1 )
		end
		
	end
	--]]

end

hook.Add("Think","SMOD_MovementStuff",SMOD_MovementStuff)
