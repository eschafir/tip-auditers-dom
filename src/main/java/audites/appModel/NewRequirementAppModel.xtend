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

}
