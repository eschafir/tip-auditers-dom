package audites.logger

import audites.logger.Logger
import audites.domain.Revision
import audites.domain.User

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

	override revisionEventType() {
		"COMPLETADO"
	}

	override revisionEventDescription() {
		"Se han completado todos los requerimientos de la revision."
	}

}
