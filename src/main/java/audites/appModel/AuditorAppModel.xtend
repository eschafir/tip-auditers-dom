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
		departmentSelected = userLoged.departments.head
		revisionSelected = userLoged.revisions.head
	}

	new(User user) {
		super(user)
		departmentSelected = userLoged.departments.head
		revisionSelected = userLoged.revisions.head
	}

	@Dependencies("revisionSelected")
	def boolean getRevisionIsNotFinished() {
		revisionSelected != null && !revisionSelected.isCompleted
	}
	@Dependencies("revisionSelected")
	def boolean getRevisionIsSelectedAuditor(){
		revisionSelected != null
	}
}
