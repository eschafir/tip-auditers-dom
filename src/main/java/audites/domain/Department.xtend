package audites.domain

import audites.repos.RepoUsers
import java.util.List
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToMany
import javax.persistence.ManyToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
@Entity
class Department {

	@Id
	@GeneratedValue
	private Long id

	@Column(length=100)
	String name

	@Column(length=100)
	String email

	@ManyToMany(fetch=FetchType.LAZY)
	Set<Revision> revisions = newHashSet()

	@ManyToOne(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	User maxAuthority

	new() {
		name = ""
		email = ""
		maxAuthority = null
	}

	def void addRevision(Revision rev) {
		if (!revisions.contains(rev)) {
			revisions.add(rev)
		}
	}

	def void removeRevision(Revision rev) {
		if (revisions.contains(rev)) {
			revisions.remove(rev)
		}
	}

	def List<User> getObtainUsers() {
		RepoUsers.instance.allInstances().filter[user|user.departments.contains(this)].toList
	}
}
