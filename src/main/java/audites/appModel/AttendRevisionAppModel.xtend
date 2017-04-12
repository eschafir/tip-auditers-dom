package audites.appModel

import audites.domain.Revision
import audites.domain.User
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import audites.emailSender.CompletedRevisionMail

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
		mailer.sendEmail(userLoged, revision.author)
	}

	override getMailer() {
		new CompletedRevisionMail(revision)
	}

}
