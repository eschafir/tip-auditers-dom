package audites.emailSender

import audites.domain.Revision
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
abstract class RevisionMail extends EmailSender {

	Revision revision

	new() {
		revision = new Revision
	}

	new(Revision rev) {
		revision = rev
	}

	override mailSubject() {
		"Revision -> " + revisionSubjectByType() + " -> " + revision.name
	}

	def abstract String revisionSubjectByType()

	override mailBody(String author) {
		revisionBodyByType() + " Usuario que realizó la acción: " + author + "."
	}

	def abstract String revisionBodyByType()

}

class NewRevisionMail extends RevisionMail {

	new() {
		super()
	}

	new(Revision rev) {
		super(rev)
	}

	override revisionSubjectByType() {
		"Nueva"
	}

	override revisionBodyByType() {
		"Se ha generado una nueva revision. Ingrese a AuditERS para poder observarla. Nombre de la nueva revision: " +
			revision.name + "."
	}

}

class CompletedRevisionMail extends RevisionMail {

	new() {
		super()
	}

	new(Revision rev) {
		super(rev)
	}

	override revisionSubjectByType() {
		"Completada"
	}

	override revisionBodyByType() {
		"Se ha completado la revision " + revision.name + ". Ingrese a AuditERS para verificar los requerimientos."
	}

}
