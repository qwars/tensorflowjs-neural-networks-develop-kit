
export tag SnowCanvas < canvas
	prop size default: 17
	prop count default: 100

	def mount
		@canvas = dom.getContext '2d'
		@snows = while count
			count-- and randomSnowPosition
		@PI = Math:PI
		schedule interval: 25

	def randomSnowPosition snow={}
		snow:left = snow:x = ( Math.random * dom:clientWidth - dom:clientHeight * 0.5 ) * @size
		snow:top = snow:y = ( Math.random * dom:clientWidth - dom:clientHeight * 0.2 ) * @size
		snow:size = @size
		snow:state = Math.random
		snow

	def tick
		@canvas:fillStyle = 'rgba(64,64,64,.8)'
		@canvas.fillRect 0, 0, dom:clientWidth, dom:clientHeight
		for snow, idx in @snows
			let o = Math.sin(  @PI ) * 32 - 16
			let u = snow:x / snow:size
			@canvas:fillStyle = "hsla({ Math.floor Math.random * 360 }, 50%, 95%, { Number snow:size < @size - 5 or @size - snow:size })"
			@canvas.beginPath
			unless snow:size < @size - 6 then @canvas.fill @canvas.arc
				snow:x / snow:size + dom:clientWidth / 2 - o
				snow:y / snow:size
				1 / snow:size * 5 + 1
				0
				Math:PI * 2
				true
			else
				@canvas.save
				@canvas.translate u + dom:clientWidth / 2 - o, snow:y / snow:size
				@canvas.rotate snow:state * ( idx % 2 ? 1 : -1 ) * ( idx % 3 / 2 + 0.1 )
				let h = @size - snow:size - 4
				let step = 6
				let e = h / ( idx % 4 + 2)
				let m = Math.random * 360
				while step
					m = h / (idx % 3 + 1)
					@canvas.lineTo -e, m
					@canvas.lineTo 0, h
					@canvas.lineTo e, m
					@canvas.lineTo 0, 0
					@canvas.rotate Math:PI / 3
					step--
				@canvas.fill
				if idx % 2 == 0
					let step = 6
					while step
						e = h / (idx % 5 + 1)
						@canvas.beginPath
						@canvas.moveTo 0, h
						@canvas.lineTo -e, h - e
						@canvas.lineTo 0, h - e
						@canvas.lineTo e, h - e
						@canvas.fill
						@canvas.rotate Math:PI / 3
						step--
				@canvas.restore
			snow:left = u
			snow:top = snow:y / snow:size
			snow:size -= 0.15
			snow:state += Math.random / 5
			if snow:size < 0.15 or snow:left < -dom:clientWidth / 2 or snow:left > dom:clientWidth / 2 or snow:top > dom:clientHeight then randomSnowPosition snow
			@PI += Math:PI / 2

	def render
		<self width=Imba.root.dom:clientWidth height=Imba.root.dom:clientHeight>