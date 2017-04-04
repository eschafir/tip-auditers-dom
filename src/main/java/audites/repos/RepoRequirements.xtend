package audites.repos

import audites.domain.Requirement
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions
import audites.domain.Revision

class RepoRequirements extends RepoDefault<Requirement> {

	static RepoRequirements instance

	static def getInstance() {
		if (instance == null) {
			instance = new RepoRequirements()
		}
		return instance
	}

	override getEntityType() {
		typeof(Requirement)
	}

	override addQueryByExample(Criteria criteria, Requirement requirement) {
		if (requirement.name != null) {
			criteria.add(Restrictions.eq("name", requirement.name))
		}
	}

	def remove(Requirement req, Revision revision) {
		revision.requirements.remove(req)
		RepoRevisions.instance.update(revision)
		super.remove(req)
	}
}
