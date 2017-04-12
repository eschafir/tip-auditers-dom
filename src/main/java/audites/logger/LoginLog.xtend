package audites.logger

import audites.logger.Logger
import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import audites.domain.User

@Accessors
@Observable
class LoginLog extends Logger {

	new() {
		super()
	}

	new(User user) {
		super(user)
	}

	override loggerType() {
		"| TIPO: SISTEMA | EVENTO: LOGIN | USUARIO: " + author.name.toUpperCase +
			" | DESCRIPCION: El usuario ha iniciado sesion en el sistema."
	}

}

class LogoutLog extends Logger {

	new() {
		super()
	}

	new(User user) {
		super(user)
	}

	override loggerType() {
		"| TIPO: SISTEMA | EVENTO: LOGOUT | USUARIO: " + author.name.toUpperCase +
			" | DESCRIPCION: El usuario ha salido del sistema."
	}

}
