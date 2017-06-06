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
			criteria.add(Restrictions.ilike("name", "%" + revision.name + "%"))
			if (revision.archived == false) {
				criteria.add(Restrictions.eq("archived", revision.archived))
			}
//			criteria.createAlias()
		}
	}
}
