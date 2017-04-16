package audites.logger

import audites.domain.Requirement
import audites.domain.Revision
import audites.domain.User
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
abstract class RequirementLog extends Logger {

	Requirement requirement
	Revision revision

	new() {
		super()
		requirement = new Requirement
		revision = new Revision
	}

	new(User author, Requirement req, Revision rev) {
		super(author)
		requirement = req
		revision = rev
	}

	override loggerType() {
		"| TIPO: REQUERIMIENTO | EVENTO: " + requirementEventType() + " | USUARIO: " + author.name.toUpperCase +
			" | DESCRIPCION: " + requirementEventDescription() + " | OBJETO: " + revision.name
	}

	def abstract String requirementEventDescription()

	def abstract String requirementEventType()

}

class ChangedStatusRequirementLog extends RequirementLog {

	new() {
		super()
	}

	new(User author, Requirement req, Revision rev) {
		super(author, req, rev)
	}

	override requirementEventDescription() {
		"El estado del requerimiento " + requirement.name + " ha cambiado. | ESTADO: " +
			requirement.requirementStatus.toUpperCase
	}

	override requirementEventType() {
		"CAMBIO DE ESTADO"
	}

}
