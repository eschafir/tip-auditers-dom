package audites.domain

import java.util.Set
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
@Entity
class User {

	@Id
	@GeneratedValue
	private Long id

	@Column
	String name

	@Column
	String password

	@Column
	String email

	@Column
	@OneToMany
	Set<Department> departments = newHashSet()

	new() {
		name = ""
		password = ""
		email = ""
	}

	def void addDepartment(Department dep) {
		if (!departments.contains(dep)) {
			departments.add(dep)
		}
	}
}
