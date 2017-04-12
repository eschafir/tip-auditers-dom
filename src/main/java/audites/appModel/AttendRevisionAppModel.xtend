package audites.appModel

import audites.domain.Revision
import audites.domain.User
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import audites.emailSender.CompletedRevisionMail
import audites.emailSender.ChangedStatusRequirementMail

@Observable
@Accessors
class AttendRevisionAppModel extends NewRevisionAppModel {

	new(Revision revision, User user) {
		super(revision, user)
	}

	def changeRequirmentStatus() {
		selectedRequirement.changeRequirmentStatus
		mailer.sendEmail
	}

	def revisionCompleted() {
		revision.isCompleted
	}

	def deriveToMaxAuthority() {
		revision.attendant = revision.responsable.maxAuthority
		mailer.sendEmail()
	}

	override getMailer() {
		if (revisionCompleted)
			new CompletedRevisionMail(revision.responsable.maxAuthority, revision.author, revision)
		else
			new ChangedStatusRequirementMail(userLoged, revision.author, revision, selectedRequirement)
	}

}
