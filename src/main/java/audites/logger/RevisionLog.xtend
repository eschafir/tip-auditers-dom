package audites.logger

import audites.logger.Logger
import audites.domain.Revision
import audites.domain.User
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
abstract class RevisionLog extends Logger {
	Revision revision

	new() {
		super()
		revision = new Revision
	}

	new(User author, Revision revision) {
		super(author)
		this.revision = revision
	}

	override loggerType() {
		"| TIPO: REVISION | EVENTO: " + revisionEventType() + " | USUARIO: " + author.name.toUpperCase +
			" | DESCRIPCION: " + revisionEventDescription() + " | OBJETO: " + revision.name
	}

	def abstract String revisionEventType()

	def abstract String revisionEventDescription()

}

class NewRevisionLog extends RevisionLog {

	new() {
		super()
	}

	new(User author, Revision revision) {
		super(author, revision)
	}

	override revisionEventType() {
		"CREACION"
	}

	override revisionEventDescription() {
		"Se ha generado una nueva revision."
	}

}

class CompletedRevisionLog extends RevisionLog {

	new() {
		super()
	}

	new(User author, Revision revision) {
		super(author, revision)
	}

	override revisionEventType() {
		"COMPLETADO"
	}

	override revisionEventDescription() {
		"Se han completado todos los requerimientos de la revision."
	}
}

@Accessors
@Observable
class DerivedRevisionLog extends RevisionLog {

	new() {
		super()
	}

	new(User author, Revision revision) {
		super(author, revision)
	}

	override revisionEventType() {
		"DERIVADO"
	}

	override revisionEventDescription() {
		author.name + " ha derivado la revision " + revision.name + " al usuario " + revision.attendant.name
	}

}
