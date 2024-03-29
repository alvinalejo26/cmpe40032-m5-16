GameOverState = Class{__includes = BaseState}

function GameOverState:init()
	gSounds['game-over-bg']:setLooping(true)
	gSounds['game-over-bg']:setVolume(0.5)
	gSounds['game-over-bg']:play()

	self.timer = 0
end

function GameOverState:enter(params)
	self.levelNumber = params.levelNumber
	self.player = params.player
	self.background = params.background


end

function GameOverState:update(dt)
	if self.timer > 2.5 and (love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return')) then
		gSounds['game-over-bg']:stop()
		gStateMachine:change('start')
	end

	self.timer = self.timer + dt
end

function GameOverState:render()
	love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], 0, 0)
	love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], 0,
		gTextures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)

	

	love.graphics.setFont(gFonts['large'])
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.printf('GAME OVER', 1, VIRTUAL_HEIGHT / 2 - 70 + 1, VIRTUAL_WIDTH, 'center')
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.printf('GAME OVER', 0, VIRTUAL_HEIGHT / 2 - 70, VIRTUAL_WIDTH, 'center')


	


	if self.timer > 1.1 and self.timer % 1 < 0.5 then
		love.graphics.setFont(gFonts['medium'])
		gPrint('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 10, VIRTUAL_WIDTH, 'center')
	end
end
