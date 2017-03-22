package audites.repos

import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions
import audites.domain.User

class RepoUsers extends RepoDefault<User> {

	static RepoUsers instance

	static def getInstance() {
		if (instance == null) {
			instance = new RepoUsers()
		}
		return instance
	}

	override getEntityType() {
		typeof(User)
	}

	override addQueryByExample(Criteria criteria, User user) {
		if (user.name != null) {
			criteria.add(Restrictions.eq("name", user.name))
		}
	}
	

}
