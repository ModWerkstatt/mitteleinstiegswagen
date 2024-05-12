local bbs2util = require "bbs2util"

function data()

return {
	tracks = {
		{ name = "vehicle/m_wagen/gw_roll_a.wav", refDist = 25.0 },
		{ name = "vehicle/m_wagen/kurve.wav", refDist = 25.0 },
		{ name = "vehicle/m_wagen/ic_bremse.wav", refDist = 25.0 },
	},	
	events = {
		openDoors = { names = { "vehicle/m_wagen/tuer_auf.wav" }, refDist = 5.0 },	
		closeDoors = { names = { "vehicle/m_wagen/tuer_zu.wav" }, refDist = 5.0 }
	},	

	updateFn = function (input)
		local speed01 = input.speed / input.topSpeed
		local refWeight = 12.0	
		local axleRefWeight = 10.0
		
		return {
			tracks = {
				{ 
					gain = bbs2util.sampleCurve({ 
									{ .0, .0 },
									{ .2, .3 },
									{ 1.0, 0.8 } }, speed01),
					pitch = bbs2util.sampleCurve({ 
									{ .0, 0.4 }, 
									{ 1.0, 1.5 } }, speed01)
				},
				
				bbs2util.squeal(input.speed, input.sideForce, input.maxSideForce),
				bbs2util.brake(input.speed, input.brakeDecel, 1.0),
			},
			events = {
				openDoors = { gain = .7, pitch = 1 },
				closeDoors = { gain = .7, pitch = 1 },
			}			
	}
	end
}
end
