package audites.domain

import java.util.List
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
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

	@OneToMany(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	List<Role> roles = newArrayList()

	@OneToMany
	Set<Revision> revisions = newHashSet()

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
