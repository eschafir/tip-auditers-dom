package audites.domain

import java.util.Set
import javax.persistence.FetchType
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import javax.persistence.Entity
import javax.persistence.Column

@Observable
@Accessors
@Entity
class Department {

	@Column(length=100)
	String name

	@Column(length=100)
	String email

	@OneToMany(fetch=FetchType.LAZY)
	Set<User> users = newHashSet

	def addUser(User user) {
		if (!users.contains(user)) {
			users.add(user)
		}
	}

	def removeUser(User user) {
		if (users.contains(user)) {
			users.remove(user)
		}
	}
}
