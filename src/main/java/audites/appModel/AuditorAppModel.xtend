package audites.appModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import audites.domain.User
import java.util.Set
import audites.domain.Department
import audites.domain.Revision
import org.uqbar.commons.utils.Dependencies

@Observable
@Accessors
class AuditorAppModel extends MainApplicationAppModel {

	Set<Department> departments = newHashSet()
	Department departmentSelected
	Revision revisionSelected

	new() {
		super()
		departmentSelected = new Department
		revisionSelected = new Revision
	}

	new(User user) {
		super(user)
		departmentSelected = new Department
		revisionSelected = new Revision
	}

	@Dependencies("revisionSelected")
	def boolean getRevisionIsSelected() {
		revisionSelected.name != ""
	}
}
