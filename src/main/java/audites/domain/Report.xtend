package audites.domain

import java.util.List
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import javax.persistence.OneToMany
import javax.persistence.FetchType
import javax.persistence.CascadeType

@Observable
@Accessors
@Entity
class Report {

	@Id
	@GeneratedValue
	private Long id

	@Column
	String name

	@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	List<Observation> observations = newArrayList()

//	HashMap<Requirement, String> observations = newHashMap()
	new() {
		name = ""
	}

	new(Revision rev) {
		name = "Reporte de revision " + rev.name
		for (Requirement req : rev.requirements) {
			observations.add(new Observation(req))
		}

	}

//	def updateName(String string) {
//		name = "Observaciones de " + string
//	}
}
