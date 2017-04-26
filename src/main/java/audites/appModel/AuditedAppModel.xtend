package audites.appModel

import audites.domain.User
import audites.emailSender.DerivedRevisionMail
import audites.logger.DerivedRevisionLog
import audites.repos.RepoRevisions
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Dependencies
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class AuditedAppModel extends AuditorAppModel {

	User selectedUser

	new() {
		super()
		selectedUser = null
//		revisionSelected = new Revision
	}

	new(User user) {
		super(user)
		selectedUser = null
//		revisionSelected = new Revision
	}

	def void setSelectedUser(User user) {
		selectedUser = user
		revisionSelected.attendant = user
		RepoRevisions.instance.update(revisionSelected)
		ObservableUtils.firePropertyChanged(this, "selectedUser")
		ObservableUtils.firePropertyChanged(this, "revisionIsSelectedAudited")
		ObservableUtils.firePropertyChanged(this, "revisionIsDerived")
		// mailer.sendEmail
		logger.write
	}

	def User getSelectedUser() {
		selectedUser
	}

	override getMailer() {
		new DerivedRevisionMail(userLoged, selectedUser, revisionSelected)
	}

	override getLogger() {
		new DerivedRevisionLog(userLoged, revisionSelected)
	}

	@Dependencies("revisionSelected")
	def boolean getRevisionIsSelectedAudited() {
		revisionSelected != null && revisionSelected.attendant == userLoged
	}

	@Dependencies("revisionSelected")
	def boolean getRevisionIsDerived() {
		revisionSelected != null && revisionSelected.attendant != userLoged
	}

	@Dependencies("revisionSelected")
	def Boolean getRevisionFinished() {
		revisionSelected != null && revisionSelected.isCompleted &&
			revisionSelected.attendant == revisionSelected.responsable.maxAuthority
	}

	@Dependencies("revisionSelected")
	def boolean getIsAsignedToAuthor() {
		revisionSelected != null && !revisionSelected.isDerivedToAuthor
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

	def deriveToAuthor() {
		revisionSelected.attendant = revisionSelected.author
		ObservableUtils.firePropertyChanged(this, "isAsignedToAuthor")
		ObservableUtils.firePropertyChanged(this, "revisionFinished")
		ObservableUtils.firePropertyChanged(this, "revisionIsSelectedAudited")
		ObservableUtils.firePropertyChanged(this, "revisionIsDerived")
		logger.write
	}

}
