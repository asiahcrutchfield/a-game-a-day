pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
-- collision practice 4 --

function _init()
	-- standard sprite size (decimal) --
		spr_h = 8
		spr_w = 8
	-- screen --
		screen = {
			-- screen dimensions (decimal) --
				w = 128,
				h = 128,
				left = 0,
				top = 0
		}
		screen.right = screen.left + (screen.w - 1)
		screen.bottom = screen.top + (screen.h - 1)
	-- player --
		player = {
			-- player dimensions (decimal) --
				w = 8,
				h = 8,
			-- player start position --
				x = 0,
				y = 0,
			-- player speed --
				speed = 2	
		}
	-- obstacle pieces --
		top_hz = {
			spr_num = 2,
			x_off = 0,
			y_off = 0,
			h = spr_h-1,
			w = spr_w-1,
			step_x = 1,
			step_y = 0,
			tw = 1,
			tw = 1,
			th = 1,
			shape = "hz_top",
			copy = 2		
		}
		left_vt = {
			spr_num = 3,
			x_off = 0,
			y_off = 0,
			h = spr_h-1,
			w = spr_w-1,
			step_x = 0,
			step_y = 1,
			tw = 1,
			th = 1,
			shape = "vt_left",
			copy = 2	
		}
		middle_hz = {
			spr_num = 4,
			x_off = 4,
			y_off = 0,
			h = spr_h-1,
			w = spr_w-1,
			step_x = 0,
			step_y = 1,
			tw = 1,
			tw = 1,
			th = 1,
			shape = "vt_middle",
			copy = 2
		}
		t_shape = create_obstacle({top_hz,middle_hz},64,64)		
end

function _update()
	-- 1. save previous x and y positions --
		old_y = player.y
		old_x = player.x
	-- 2. update player postion --
		if btn(0) then
			player.x -= player.speed
		end
		if btn(1) then
			player.x += player.speed
		end
		if btn(2) then
			player.y -= player.speed
		end
		if btn(3) then
			player.y += player.speed
		end
	-- 3. get player measurements --
		player.top = player.y
		player.left = player.x
		player.right = player.left + (player.w-1)
		player.bottom = player.top + (player.h-1) 
	-- 4. create screen collision function --
	-- 5. apply screen collision --
		if screen_collision() then
			player.y = old_y
			player.x = old_x
		end
	-- 6. create obstacle function --
	-- 7. create obstacle collision function --
	-- 8. loop through obstacle shape --
		for pce in all(t_shape.pieces) do
    if obstacle_collision(
    	pce.left,pce.right,
    	pce.top,pce.bottom) then
        player.y = old_y
        player.x = old_x
    end
		end
end

function _draw()
	cls()
	-- player --
		spr(1,player.x,player.y)
	-- t-obstacle --
		for pce in all(t_shape.pieces) do
			spr(pce.spr_num, pce.x, pce.y)					
		end
end

function screen_collision()
	if player.top < screen.top or 
		player.bottom > screen.bottom or
		player.left < screen.left or
		player.right > screen.right then
	return true		
	end
	
	return false
end

function obstacle_collision(
	left,right,top,bottom)
	if 
		player.top <= bottom and
		player.right >= left and
		player.left <= right and 
		player.bottom >= top then
		 return true
	end
	return false
end

function create_obstacle(shape,
	start_x, start_y)
	-- 1. define start points --
		local obstacle = {
			x = start_x,
			y = start_y,
			pieces = {}
		}
	-- 2. loop through pieces --
		for pce in all(shape) do
	-- 3. use a for loop to place pieces --
			for i=0, pce.copy-1 do
					local piece = {
						spr_num = pce.spr_num,
						x = start_x + pce.x_off + (i * spr_w * (pce.step_x or 0)),
						y = start_y + pce.y_off + (i * spr_w * (pce.step_y or 0)),
						h = spr_h-1,
						w = spr_w-1,
						tw = pce.tw,
						th = pce.th			
					}
					piece.top = piece.y
					piece.left = piece.x					
					-- calculations based on pieces --
						if pce.shape == "hz_top" then
							piece.right = piece.left+pce.w
							piece.bottom = piece.top+pce.h-6
						elseif pce.shape == "vt_left" then
							piece.right = piece.left+pce.w
							piece.bottom = piece.top + pce.h
						elseif pce.shape == "vt_middle" then
							piece.left = piece.left + 4
							piece.right = piece.left + 1
							piece.bottom = piece.top + pce.h
						else
					-- default box calculation --
							piece.bottom = piece.top+pce.h
							piece.right = piece.left+pce.w
						end
					add(obstacle.pieces, piece)
			end
		end
	-- 4. get obstacle list --
		return obstacle
end
__gfx__
00000000aaaaaaaa7777777777000000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000a77aa77a7777777777000000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700a77aa77a0000000077000000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000aaaaaaaa0000000077000000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000aaaaaaaa0000000077000000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007007aaaaaa70000000077000000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000a777777a0000000077000000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000aaaaaaaa0000000077000000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
