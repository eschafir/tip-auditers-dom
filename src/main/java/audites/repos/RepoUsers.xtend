package audites.repos

import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions
import audites.domain.User
import org.apache.commons.codec.digest.DigestUtils

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

	override create(User t) {
		t.password = DigestUtils.sha256Hex(t.password)
		super.create(t)
	}

	override addQueryByExample(Criteria criteria, User user) {
		if (user.username != null) {
			criteria.add(Restrictions.eq("username", user.username))
		}
	}
}
