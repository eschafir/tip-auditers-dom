package audites.appModel

import audites.domain.User
import audites.repos.RepoUsers
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class AdminPanelAppModel extends MainApplicationAppModel {
	RepoUsers repo
	User selectedUser

	new() {
		super()
		repo = RepoUsers.instance
		selectedUser = new User
	}

	new(User user) {
		super(user)
		repo = RepoUsers.instance
		selectedUser = new User
	}

	def createUser() {
	}
}
