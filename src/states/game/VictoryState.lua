VictoryState = Class{__includes = BaseState}

function VictoryState:init()
	gSounds['victory-bg']:setLooping(true)
	gSounds['victory-bg']:setVolume(0.5)
	gSounds['victory-bg']:play()

	self.timer = 0
end

function VictoryState:enter(params)
	self.levelNumber = params.levelNumber
	self.player = params.player
	self.background = params.background

end

function VictoryState:update(dt)
	if self.timer > 3 and (love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return')) then
		gSounds['victory-bg']:stop()
		gStateMachine:change('play', {
			level = LevelMaker.generate(self.player.map.width + 10, 10),
			background = math.random(3),
			levelNumber = self.levelNumber + 1,
			score = self.player.score,

		})
	end

	self.timer = self.timer + dt
end

function VictoryState:render()
	love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], 0, 0)
	love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], 0,
	gTextures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)

	

	love.graphics.setFont(gFonts['large'])
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.printf('Lv. ' .. tostring(self.levelNumber) .. ' Complete', 1, VIRTUAL_HEIGHT / 2 - 70 + 1, VIRTUAL_WIDTH, 'center')
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.printf('Lv. ' .. tostring(self.levelNumber) .. ' Complete', 0, VIRTUAL_HEIGHT / 2 - 70, VIRTUAL_WIDTH, 'center')

		


	if self.timer > 3 and self.timer % 1.5 < 0.75 then
		love.graphics.setFont(gFonts['medium'])
		gPrint('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 30, VIRTUAL_WIDTH, 'center')
	end
end
