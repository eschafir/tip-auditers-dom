package audites.appModel

import audites.domain.Requirement
import audites.domain.Revision
import audites.domain.User
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class GenerateReportAppModel extends MainApplicationAppModel {

	Revision revision
	Requirement requirementSelected
	String observation

	new() {
		super()
	}

	new(User user, Revision revision) {
		super(user)
		this.revision = revision
		requirementSelected = null
		observation = ""
	}

}
