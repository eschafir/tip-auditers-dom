package audites.appModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import audites.domain.User
import java.util.List
import audites.repos.RepoUsers

@Observable
@Accessors
class AdminPanelAppModel extends MainApplicationAppModel {
	RepoUsers repo
	List<User> userList
	User selectedUser

	new() {
		userLoged = new User
		repo = RepoUsers.instance
		userList = newArrayList()
		selectedUser = new User
	}

	def createUser() {
	}
}
