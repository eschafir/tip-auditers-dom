package audites.appModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import audites.domain.User

@Observable
@Accessors
class LoginAppModel {
	
	User userLoged
	String passwordSubmited
}
