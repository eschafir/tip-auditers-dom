package audites.appModel

import audites.domain.Revision
import audites.domain.User
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class AttendRevisionAppModel extends NewRevisionAppModel {

	new(Revision revision, User user) {
		super(revision, user)
	}

	def changeRequirmentStatus() {
		selectedRequirement.changeRequirmentStatus
	}

	def revisionCompleted() {
		revision.isCompleted
	}

	def deriveToMaxAuthority() {
		revision.attendant = revision.responsable.maxAuthority
	}

}
