package audites.domain

import java.util.Set
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import javax.persistence.FetchType

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
	
	@OneToMany(fetch=FetchType.EAGER)
	Set<Role> roles = newHashSet()

	new() {
		name = ""
		password = ""
		email = ""
	}

	new(String n, String p, String m) {
		name = n
		password = p
		email = m
	}

	def void addDepartment(Department dep) {
		if (!departments.contains(dep)) {
			departments.add(dep)
		}
	}

	def getRevisions() {
		var revisions = newHashSet()
		for (Department d : departments) {
			for (Revision r : d.revisions) {
				if (!revisions.contains(r)) {
					revisions.add(r)
				}
			}
		}
		return revisions
	}
}
