package audites.domain.States

import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue

@Observable
@Accessors
@Entity
class State {
	@Id
	@GeneratedValue
	private Long id
	
	String name
	
	Boolean isRevision
	
}