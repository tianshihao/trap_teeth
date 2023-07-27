local function TrapComponentPostInit(self)
	function self:Explode(target)
		self:StopTesting()
		self.target = target
		self.issprung = true
		self.inactive = false
		if self.onexplode then
			self.onexplode(self.inst, target)
		end

		self.inst:DoPeriodicTask(0.0, function()
			if (self.issprung) then
				self:Reset()
			end
		end)
	end
end

AddComponentPostInit("mine", TrapComponentPostInit)

AddPrefabPostInit("trap_teeth", function(inst)
	if inst.components.finiteuses ~= nil then
		inst.components.finiteuses = nil
	end

	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM
	inst.scrapbook_damage = 100
end)

GLOBAL.AllRecipes.trap_teeth.ingredients[1].amount = 1
GLOBAL.AllRecipes.trap_teeth.ingredients[2] = nil
GLOBAL.AllRecipes.trap_teeth.ingredients[3] = nil
