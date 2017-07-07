package audites.appModel

import audites.domain.Evidence
import audites.domain.Revision
import audites.domain.User
import audites.emailSender.ChangedStatusRequirementMail
import audites.emailSender.CompletedRevisionMail
import audites.logger.ChangedStatusRequirementLog
import audites.logger.CompletedRevisionLog
import audites.logger.DerivedRevisionLog
import audites.repos.RepoRequirements
import audites.repos.RepoRevisions
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.ObservableUtils
import audites.repos.RepoEvidences
import org.uqbar.commons.utils.Dependencies

@Observable
@Accessors
class AttendRevisionAppModel extends NewRevisionAppModel {

	String selectedFile
	Evidence evidenceSelected

	new(Revision revision, User user) {
		super(revision, user)
		selectedFile = ""
		evidenceSelected = null
	}

	def void setSelectedFile(String s) {
		if (s != null) {
			selectedFile = s
			selectedRequirement.addEvidence(new Evidence(selectedFile))
			RepoRequirements.instance.update(selectedRequirement)
			RepoRevisions.instance.update(revision)
		}
	}

	def changeRequirmentStatus() {
		selectedRequirement.changeRequirmentStatus
		// mailer.sendEmail
		logger.write
		ObservableUtils.firePropertyChanged(this, "hasRequirements")
		ObservableUtils.firePropertyChanged(this, "hasEvidence")
	}

	def revisionCompleted() {
		revision.isCompleted
	}

	def revisionMaxAuthority() {
		revision.responsable.maxAuthority
	}

	def deriveToMaxAuthority() {
		revision.attendant = revisionMaxAuthority
		RepoRevisions.instance.update(revision)
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

	def deleteEvidence() {
		RepoEvidences.instance.remove(selectedRequirement, evidenceSelected)
	}

	@Dependencies("evidenceSelected")
	def boolean getHasEvidence() {
		selectedRequirement != null && !selectedRequirement.isCompleted && evidenceSelected != null
	}

}
