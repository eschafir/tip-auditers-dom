package audites.appModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import audites.domain.User
import java.util.List
import audites.repos.RepoRevisions

@Observable
@Accessors
class AuditedAppModel extends AuditorAppModel {

	User selectedUser

	new() {
		super()
		selectedUser = null
	}

	new(User user) {
		super(user)
		selectedUser = null
	}

	def List<User> getObtainUsers() {
		var result = newArrayList()
		val users = revisionSelected.responsable.obtainUsers
		for (User u : users) {
			if (u != userLoged) {
				result.add(u)
			}
		}
		return result
	}

	def applyAttendant() {
		revisionSelected.attendant = selectedUser
		RepoRevisions.instance.update(revisionSelected)
	}

	def getMaximumResponsable() {
		revisionSelected.responsable.maxAuthority
	}

}
