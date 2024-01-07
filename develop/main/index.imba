import './index.styl'

import ErrorPageState from './error-page-state'

export tag Sketch < main
	@classes = []

	def routeDidEnter
		application.isErrorPageState = undefined
		self

	def render
		<self>
			if application.isErrorPageState then <ErrorPageState
				route="{ router.root }/:collection/*:document*">

