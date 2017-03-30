package audites.appModel

import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import audites.domain.Revision
import audites.domain.Requirement
import audites.repos.RepoRevisions
import audites.repos.RepoRequirements
import audites.domain.User

@Accessors
@Observable
class NewRequirementAppModel extends MainApplicationAppModel {
	Requirement requirement
	Revision revision

	new(Revision revision) {
		super()
		requirement = new Requirement
		this.revision = revision
	}

	new(Revision revision, Requirement requirement, User user) {
		super(user)
		this.requirement = requirement
		this.revision = revision
	}

	new(Revision revision, User user) {
		super(user)
		requirement = new Requirement
		this.revision = revision
	}

	def createRequirement() {
		RepoRequirements.instance.create(requirement)
		revision.addRequirement(requirement)
		RepoRevisions.instance.update(revision)
	}
	
	def String getReqName() {
		return requirement.name
	}

	def void setReqName(String name) {
		requirement.name = name
		RepoRequirements.instance.update(requirement)
	}

	def String getReqDescription() {
		return requirement.descripcion
	}

	def void setReqDescription(String desc) {
		requirement.descripcion = desc
		RepoRequirements.instance.update(requirement)
	}

}
