package audites.appModel

import audites.domain.User
import audites.emailSender.EmailSender
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class MainApplicationAppModel {

	User userLoged
	EmailSender mailer

	new() {
		userLoged = new User
		mailer = null
	}

	new(User user) {
		userLoged = user
		mailer = null
	}

}
