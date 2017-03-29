package audites.appModel

import audites.domain.User
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class MainApplicationAppModel {

	User userLoged

	new() {
		userLoged = new User
	}

	new(User user) {
		userLoged = user
	}

}
