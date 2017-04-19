package audites.appModel

import audites.domain.Revision
import audites.domain.User
import audites.emailSender.ChangedStatusRequirementMail
import audites.emailSender.CompletedRevisionMail
import audites.logger.ChangedStatusRequirementLog
import audites.logger.CompletedRevisionLog
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import audites.logger.DerivedRevisionLog
import audites.repos.RepoRequirements
import audites.repos.RepoRevisions
import audites.domain.Evidence

@Observable
@Accessors
class AttendRevisionAppModel extends NewRevisionAppModel {

	String selectedFile

	new(Revision revision, User user) {
		super(revision, user)
		selectedFile = ""
	}

	def void setSelectedFile(String s) {
		selectedFile = s
		selectedRequirement.addEvidence(new Evidence(selectedFile))
		RepoRequirements.instance.update(selectedRequirement)
		RepoRevisions.instance.update(revision)
	}

	def changeRequirmentStatus() {
		selectedRequirement.changeRequirmentStatus
		// mailer.sendEmail
		logger.write
	}

	def revisionCompleted() {
		revision.isCompleted
	}

	def revisionMaxAuthority() {
		revision.responsable.maxAuthority
	}

	def deriveToMaxAuthority() {
		revision.attendant = revisionMaxAuthority
		val log = new DerivedRevisionLog(userLoged, revision)
		log.write
	}

	override getMailer() {
		if (revisionCompleted) {
			new CompletedRevisionMail(revisionMaxAuthority, revision.author, revision)
		} else
			new ChangedStatusRequirementMail(userLoged, revisionMaxAuthority, revision, selectedRequirement)
	}

	override getLogger() {
		if (revisionCompleted) {
			new CompletedRevisionLog(userLoged, revision)
		} else
			new ChangedStatusRequirementLog(userLoged, selectedRequirement, revision)
	}

	def Boolean revisionCompletedAndUserIsNotMaxAuthority() {
		revisionCompleted && userLoged != revisionMaxAuthority
	}
}
