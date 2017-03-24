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
		if (user.email != null) {
			criteria.add(Restrictions.eq("email", user.email))
		}
	}
	

}
