package audites.domain

import java.util.List
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToMany
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
	String username

	@Column
	String password

	@Column
	String email

	@ManyToMany(fetch=FetchType.LAZY)
	Set<Department> departments = newHashSet()

	@ManyToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	List<Role> roles = newArrayList()

	@ManyToMany(fetch=FetchType.LAZY)
	List<Revision> revisions = newArrayList()

	new() {
		name = ""
		username = ""
		password = ""
		email = ""
	}

	new(String n, String u, String p, String m) {
		name = n
		username = u
		password = p
		email = m
	}

	def void addDepartment(Department dep) {
		if (!departments.contains(dep)) {
			departments.add(dep)
		}
	}

	def void addRevision(Revision rev) {
		if(!revisions.contains(rev)) revisions.add(rev)
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

	def Boolean maximumResponsable(Department dep) {
		dep.maxAuthority == this
	}

}
