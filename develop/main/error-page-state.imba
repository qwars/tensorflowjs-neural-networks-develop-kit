
const Error403 = require '../images/error403.svg'
const Error503 = require '../images/error503.svg'
const Error404 = require '../images/error404.svg'

tag ErrorStatus
	def render
		<self>
			<img src=Error503>
			<span> data

export tag ErrorPageState < figure
	def render
		<self>
			if application.isErrorPageState isa String then <img src=Error403>
			elif application.isErrorPageState:status === 404 then <img src=Error404>
			else <ErrorStatus[ application.isErrorPageState:status ]>

			<figcaption>
				<h4>
					if application.isErrorPageState isa String then application.isErrorPageState
					else application.isErrorPageState:error
				<p>
					if application.isErrorPageState isa String
						"Нет доступа к серверу"
						<dfn> "Проверьте подключение VPN"
					elif application.isErrorPageState:status !== 404
						application.isErrorPageState:message
					else "Для этого { params:document ? 'элемента' : 'раздела' } нет возможности получить данные"
	        
