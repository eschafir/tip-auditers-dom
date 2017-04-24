package audites.repos

import org.hibernate.Criteria
import audites.domain.Revision
import org.hibernate.criterion.Restrictions

class RepoRevisions extends RepoDefault<Revision> {
	static RepoRevisions instance

	static def getInstance() {
		if (instance == null) {
			instance = new RepoRevisions()
		}
		return instance
	}

	override getEntityType() {
		typeof(Revision)
	}

	override addQueryByExample(Criteria criteria, Revision revision) {
		if (revision.name != null) {
			criteria.add(Restrictions.eq("name", revision.name))
		}
	}

	def search(String name) {
		allInstances.filter[revision|this.match(name, revision.name)].toList
	}

	def match(Object expectedValue, Object realValue) {
		if (expectedValue == null) {
			return true
		}
		if (realValue == null) {
			return false
		}
		realValue.toString().toLowerCase().contains(expectedValue.toString().toLowerCase())
	}

}
