package audites.appModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import audites.domain.User
import java.util.List

@Observable
@Accessors
class AdminPanelAppModel {
	User userLoged
	List<User> userList
	User selectedUser

	new() {
		userLoged = new User
		userList = newArrayList()
		selectedUser = new User
	}
}
