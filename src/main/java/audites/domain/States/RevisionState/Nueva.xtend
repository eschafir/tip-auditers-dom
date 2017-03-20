package audites.domain.States.RevisionState

import audites.domain.States.RevisionState.RevisionState
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Nueva extends RevisionState {
	new() {
		name = "Nueva"
	}

}
