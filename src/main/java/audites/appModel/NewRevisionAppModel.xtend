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

	RepoRevisions repo
	List<Department> departments
	Revision revision
	Department selectedDepartment

	new() {
		repo = RepoRevisions.instance
		departments = RepoDepartments.instance.allInstances
		revision = new Revision
		selectedDepartment = new Department
	}

	new(User user) {
		super(user)
		repo = RepoRevisions.instance
		departments = RepoDepartments.instance.allInstances
		revision = new Revision
		selectedDepartment = new Department
	}

	def createRevison() {
		repo.create(revision)
	}

}
