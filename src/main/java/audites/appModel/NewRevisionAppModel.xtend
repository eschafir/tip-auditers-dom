package audites.appModel

import audites.domain.Department
import audites.domain.Requirement
import audites.domain.Revision
import audites.domain.User
import audites.repos.RepoDepartments
import audites.repos.RepoRevisions
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class NewRevisionAppModel extends MainApplicationAppModel {

	List<Department> departments
	Revision revision
	Requirement selectedRequirement
	Department selectedDepartment

	new() {
		departments = RepoDepartments.instance.allInstances
		revision = new Revision
		selectedRequirement = new Requirement
		selectedDepartment = new Department
	}

	new(User user) {
		super(user)
		departments = RepoDepartments.instance.allInstances
		revision = new Revision
		selectedRequirement = new Requirement
		selectedDepartment = new Department
	}

	new(Requirement requirement, Revision revision) {
		this.revision = revision
		this.selectedRequirement = requirement
	}

	new(Revision revision) {
		this.revision = revision
	}

	def createRevison() {
		revision.author = userLoged
		userLoged.revisions.add(revision)
		selectedDepartment.addRevision(revision)
		RepoRevisions.instance.create(revision)
		RepoDepartments.instance.update(selectedDepartment)
	}

	def boolean hasRequirements() {
		(revision.requirements.size > 0)
	}

	def String getRevisionName() {
		this.revision.name
	}

	def void setRevisionName(String name) {
		revision.name = name
		RepoRevisions.instance.update(revision)
	}
}
