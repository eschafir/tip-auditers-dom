package audites.domain

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import javax.persistence.OneToMany
import javax.persistence.CascadeType
import java.util.Set
import javax.persistence.FetchType
import org.uqbar.commons.model.UserException

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

	@OneToMany(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	Set<Revision> revisions = newHashSet()

	new() {
		name = ""
		email = ""
	}

	def void addRevision(Revision rev) {
		if (!revisions.contains(rev)) {
			revisions.add(rev)
		}
	}

}
