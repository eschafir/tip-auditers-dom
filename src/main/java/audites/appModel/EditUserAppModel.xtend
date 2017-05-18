package audites.appModel

import audites.domain.User
import audites.repos.RepoUsers
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Dependencies
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class EditUserAppModel extends NewUserAppModel {

	Object propertyToEdit

	new() {
		super()
	}

	new(User user) {
		super(user)
		propertyToEdit = null
	}

	new(User userLoged, User user) {
		super(userLoged)
		this.user = user
		propertyToEdit = null
	}

	new(User user, Object obj) {
		super()
		this.user = user
		propertyToEdit = obj
	}

	def update() {
		validateUserInfo
		RepoUsers.instance.update(user)
	}

	def changeUserStatus() {
		user.changeStatus(!user.enabled)
		RepoUsers.instance.update(user)
	}

	@Dependencies("user")
	def Boolean getUserIsEnabled() {
		user.enabled
	}

	@Dependencies("user")
	def Boolean getUserIsDisabled() {
		!user.enabled
	}
}
