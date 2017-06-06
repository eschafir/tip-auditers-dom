package audites.domain

import java.util.List
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.OneToMany
import org.uqbar.commons.utils.Observable
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

	@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL, orphanRemoval=true)
	List<Requirement> requirements

	@Column(length=500)
	String observations

	new() {
		name = ""
		requirements = newArrayList()
		observations = ""
	}
	
	new(Revision rev){
		name = "Reporte de revision " + rev.name
		requirements = rev.requirements
		observations = ""
	}

//	def updateName(String string) {
//		name = "Observaciones de " + string
//	}

}
