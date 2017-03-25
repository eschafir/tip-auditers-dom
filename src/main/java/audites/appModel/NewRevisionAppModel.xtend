package audites.appModel

import audites.domain.Revision
import audites.repos.RepoRevisions
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import audites.domain.User
import audites.domain.Department
import audites.repos.RepoDepartments
import java.util.List

@Observable
@Accessors
class NewRevisionAppModel extends MainApplicationAppModel {

	List<Department> departments
	Revision revision
	Department selectedDepartment

	new() {
		departments = RepoDepartments.instance.allInstances
		revision = new Revision
		selectedDepartment = new Department
	}

	new(User user) {
		super(user)
		departments = RepoDepartments.instance.allInstances
		revision = new Revision
		selectedDepartment = new Department
	}

	def createRevison() {
		revision.author = userLoged
		userLoged.revisions.add(revision)
		selectedDepartment.addRevision(revision)
		RepoRevisions.instance.create(revision)
		RepoDepartments.instance.update(selectedDepartment)
	}

}
