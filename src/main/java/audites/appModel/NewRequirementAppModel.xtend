package audites.appModel

import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import audites.domain.Revision
import audites.domain.Requirement
import audites.repos.RepoRevisions

@Accessors
@Observable
class NewRequirementAppModel {
	Requirement requirement
	Revision revision

	new(Requirement requirement, Revision revision) {
		this.requirement = requirement
		this.revision = revision
	}

	def createRequirement() {
		revision.addRequirement(requirement)
		RepoRevisions.instance.update(revision)
	}

}
