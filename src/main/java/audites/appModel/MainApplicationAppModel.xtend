package audites.appModel

import audites.domain.User
import audites.emailSender.EmailSender
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import audites.logger.Logger
import audites.logger.LogoutLog

@Observable
@Accessors
class MainApplicationAppModel {

	User userLoged
	EmailSender mailer
	Logger logger

	new() {
		userLoged = new User
		mailer = null
		logger = null
	}

	new(User user) {
		userLoged = user
		mailer = null
		logger = null
	}

	def writeLog(User user) {
		logger = new LogoutLog(user)
		logger.write
	}
		def getPathImagen() {
		"company.png"
	}
}
