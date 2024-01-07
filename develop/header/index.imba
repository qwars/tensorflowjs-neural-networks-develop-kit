import './index.styl'

const Logo = require '../images/Logo.svg?source'

export tag Sketch < header
	@classes = []

	def toggleShowSnow
		application.waiting = true

	def render
		<self>
			<a route-to="/" html=Logo :tap.toggleShowSnow>
			<nav>
				<a route-to="/questionnaire" aria-current=(params:collection === "questionnaire")> "Опросник"
			<aside>
