package audites.domain

import java.util.List
import java.util.Set
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
	List<Department> departments = newArrayList()

	@ManyToMany(fetch=FetchType.LAZY)
	List<Role> roles = newArrayList()

	@ManyToMany(fetch=FetchType.LAZY)
	List<Revision> revisions = newArrayList()

	@Column
	Boolean enabled = true

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
		if(!departments.contains(dep)) departments.add(dep)
	}

	def void removeDepartment(Department dep) {
		if(departments.contains(dep)) departments.remove(dep)
	}

	def addRole(Role role) {
		if(!roles.contains(role)) roles.add(role)
	}

	def removeRole(Role role) {
		if(roles.contains(role)) roles.remove(role)
	}

	def void addRevision(Revision rev) {
		if(!revisions.contains(rev)) revisions.add(rev)
	}

	def List<Revision> getRevisions() {
		departments.map[revisions].flatten.toList
	}

	def Set<String> getDepartmentsNames() {
		departments.map [ name ].toSet
	}

	def void changeStatus(Boolean b) {
		enabled = b
	}
}
