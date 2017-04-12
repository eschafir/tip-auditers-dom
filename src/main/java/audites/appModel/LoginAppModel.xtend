package audites.appModel

import audites.domain.User
import audites.repos.RepoUsers
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.utils.Dependencies
import org.apache.commons.codec.digest.DigestUtils

@Observable
@Accessors
class LoginAppModel {
	User userLoged
	String passwordSubmited

	new() {
		userLoged = new User
		passwordSubmited = ""
	}

	def validateUser() {
		validateEmptyFields(userLoged.username, passwordSubmited)
		validateUsername(userLoged.username)
		validatePassword(passwordSubmited)
	}

	def validateEmptyFields(String usernameSubmited, String submitedPass) {
		if (usernameSubmited == null) {
			throw new UserException("Ingrese el usuario.")
		} else if (submitedPass == null) {
			throw new UserException("Ingrese la contraseña.")
		}
	}

	def validateUsername(String string) {
		if (!RepoUsers.instance.searchByExample(userLoged).exists[it.username == string]) {
			throw new UserException("Usuario incorrecto o inexistente")
		}
	}

	def validatePassword(String string) {
		if (!RepoUsers.instance.searchByExample(userLoged).exists[it.password == DigestUtils.sha256Hex(string)]) {
			throw new UserException("Clave incorrecta")
		}
	}

	def obtainUser() {
		return RepoUsers.instance.searchByExample(userLoged).head
	}

	@Dependencies("passwordSubmited")
	def boolean getPasswordIngresed() {
		passwordSubmited != ""
	}
}
