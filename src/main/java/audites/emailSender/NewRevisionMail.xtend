package audites.emailSender

import audites.domain.Revision
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class NewRevisionMail extends EmailSender {

	Revision revision

	new() {
	}

	new(Revision rev) {
		revision = rev
	}

	override mailSubject() {
		"Nueva Revision -> " + revision.name
	}

	override mailBody(String author) {
		"Se ha creado una nueva revision. El usuario " + author + " generó una nueva revision llamada " +
			revision.name + "."
	}

}
