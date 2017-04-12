package audites.emailSender

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import audites.domain.Requirement
import audites.domain.User
import audites.domain.Revision

@Accessors
@Observable
abstract class RequirementMail extends EmailSender {

	Requirement requirement
	Revision revision

	new() {
		super()
		requirement = new Requirement
		revision = new Revision
	}

	new(User author, User reciever, Revision rev, Requirement req) {
		super(author, reciever)
		revision = rev
		requirement = req
	}

	override mailSubject() {
		"Requerimiento -> " + requirementSubjectByType + " -> " + requirement.name
	}

	override mailBody(String author) {
		requirementBodyByType() + " Realizado por: " + author + "."
	}

	def abstract String requirementSubjectByType()

	def abstract String requirementBodyByType()

}

class ChangedStatusRequirementMail extends audites.emailSender.RequirementMail {

	new() {
		super()
	}

	new(User author, User reciever, Revision rev, Requirement req) {
		super(author, reciever, rev, req)
	}

	override requirementSubjectByType() {
		requirement.requirementStatus
	}

	override requirementBodyByType() {
		"Se ha modificado el requerimiento: " + "'" + requirement.name + "' de la revision " + revision.name + "." +
			"\r \n" + "Status: " + requirement.requirementStatus + "."
	}

}
