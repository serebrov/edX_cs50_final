StateMachine = Class{}

function StateMachine:init(states)
	-- self.empty = {
	-- 	render = function() end,
	-- 	update = function() end,
	-- 	processAI = function() end,
	-- 	enter = function() end,
	-- 	exit = function() end
	-- }
	self.states = states or {} -- [name] -> [function that returns states]
	self._current = nil -- self.empty
end

function StateMachine:current_state()
	if self._current == nil then
		-- raise an error
		error('No current state!')
	end
	return self._current
end

function StateMachine:change(stateName, enterParams)
	assert(self.states[stateName]) -- state must exist!
	if self._current then
		self:current_state():exit()
	end
	self._current = self.states[stateName]()
	self._current:enter(enterParams)
end

function StateMachine:update(dt)
	self:current_state():update(dt)
end

function StateMachine:render()
	self:current_state():render()
end

--[[
	Used for states that can be controlled by the AI to influence update logic. By having this and
	not just bundling the decision-making into :update, we allow ourselves to reuse states between
	the player and agents in our game, rather than create a separate state for each (or at least
	allow the player to use the base state and then call its own inherited version of that state to
	save on code) See how PlayerWalkState calls EntityWalkState.update within :update for an example.
]]
function StateMachine:processAI(params, dt)
	self:current_state():processAI(params, dt)
end
