package audites.repos

import audites.domain.Role
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions

class RepoRoles extends RepoDefault<Role> {

	static RepoRoles instance

	static def getInstance() {
		if (instance == null) {
			instance = new RepoRoles()
		}
		return instance
	}

	override getEntityType() {
		typeof(Role)
	}

	override addQueryByExample(Criteria criteria, Role role) {
		if (role.name != null) {
			criteria.add(Restrictions.eq("name", role.name))
		}
	}
}
