package audites.appModel

import audites.domain.User
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class MainApplicationAppModel {

	User userLoged
	String image

	new() {
		userLoged = new User
		image = null
	}

	new(User user) {
		userLoged = user
		image = null
	}

}
