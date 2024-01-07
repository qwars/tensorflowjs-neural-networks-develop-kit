import SnowCanvas from './images/snow'

export tag Application < output
	prop waiting
	prop isErrorPageState
	prop messages default: []

	def setup
		const output = self
		extend tag element
			def application
				output

	def isLoading
		@waiting

	def invalidCompletion e
		@isErrorPageState = ( e:stack and e:message ) or ( not e:ok and await e.json )
		e

	def render
		<self .loading=!!isLoading > <SnowCanvas>
