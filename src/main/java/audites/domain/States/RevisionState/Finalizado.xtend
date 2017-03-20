package audites.domain.States.RevisionState

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import audites.domain.States.RevisionState.RevisionState

@Observable
@Accessors
class Finalizado extends RevisionState {

	new() {
		name = "Finalizado"
	}

}
