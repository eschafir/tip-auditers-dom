package audites.emailSender

import audites.domain.Revision
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import audites.domain.User

@Accessors
@Observable
abstract class RevisionMail extends EmailSender {

	Revision revision

	new() {
		super()
		revision = new Revision
	}

	new(User a, User r, Revision rev) {
		super(a, r)
		revision = rev
	}

	override mailSubject() {
		"Revision -> " + revisionSubjectByType() + " -> " + revision.name
	}

	override mailBody(String author) {
		revisionBodyByType() + " Usuario que realizó la acción: " + author + "."
	}

	def abstract String revisionSubjectByType()

	def abstract String revisionBodyByType()

}

class NewRevisionMail extends RevisionMail {

	new() {
		super()
	}

	new(User a, User r, Revision rev) {
		super(a, r, rev)
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

	new(User a, User r, Revision rev) {
		super(a, r, rev)
	}

	override revisionSubjectByType() {
		"Completada"
	}

	override revisionBodyByType() {
		"Se ha completado la revision " + revision.name + ". Ingrese a AuditERS para verificar los requerimientos."
	}

}

class DerivedRevisionMail extends RevisionMail {

	new() {
		super()
	}

	new(User a, User r, Revision rev) {
		super(a, r, rev)
	}

	override revisionSubjectByType() {
		"Derivada"
	}

	override revisionBodyByType() {
		"Se te ha asignado una nueva revision. Ingrese a AuditERS para atenderla. Nombre de la revision: " +
			revision.name + "." + "\r \n"
	}

}
