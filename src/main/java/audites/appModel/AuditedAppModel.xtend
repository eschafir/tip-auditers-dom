package audites.appModel

import audites.domain.User
import audites.repos.RepoRevisions
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.utils.Dependencies

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

	def void setSelectedUser(User user) {
		selectedUser = user
		revisionSelected.attendant = user
		RepoRevisions.instance.update(revisionSelected)
		ObservableUtils.firePropertyChanged(this, "selectedUser")
		ObservableUtils.firePropertyChanged(this, "revisionIsSelectedAudited")

	}

	def User getSelectedUser() {
		selectedUser
	}

	@Dependencies("revisionSelected")
	def boolean getRevisionIsSelectedAudited() {
		revisionSelected != null && revisionSelected.attendant == userLoged
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

	def getMaximumResponsable() {
		revisionSelected.responsable.maxAuthority
	}

}
