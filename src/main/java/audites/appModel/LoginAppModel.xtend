package audites.appModel

import audites.domain.User
import audites.repos.RepoUsers
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

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
		validateEmptyFields(userLoged.email, passwordSubmited)
		validateMail(userLoged.email)
		validatePassword(passwordSubmited)
	}

	def validateEmptyFields(String mailSubmited, String submitedPass) {
		if (mailSubmited == null) {
			throw new UserException("Ingrese el usuario.")
		} else if (submitedPass == null) {
			throw new UserException("Ingrese la contraseña.")
		}
	}

	def validateMail(String string) {
		if (!RepoUsers.instance.searchByExample(userLoged).exists[it.email == string]) {
			throw new UserException("Usuario incorrecto o inexistente")
		}

	}

	def validatePassword(String string) {
		if (!RepoUsers.instance.searchByExample(userLoged).exists[it.password == string]) {
			throw new UserException("Clave incorrecta")
		}
	}

	def obtainUser() {
		return RepoUsers.instance.searchByExample(userLoged).head

	}

}
