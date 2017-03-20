package audites.domain.States.RequirementState

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import audites.domain.States.RequirementState.RequirementState

@Observable
@Accessors
class Pendiente extends RequirementState {
	new() {
		name = "Pendiente"
	}

}
