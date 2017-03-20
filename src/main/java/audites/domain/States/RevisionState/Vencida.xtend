package audites.domain.States.RevisionState

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Vencida extends RevisionState {
	new() {
		name = "Vencida"
	}

}
