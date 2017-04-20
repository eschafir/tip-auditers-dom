package audites.domain

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Column
import java.nio.file.Paths

@Accessors
@Observable
@Entity
class Evidence {

	@Id
	@GeneratedValue
	private Long id

	@Column
	String path

	new() {
		path = ""
	}

	new(String p) {
		path = p
	}
	
	def String getPath(){
		Paths.get(path).fileName.toString
	}
	
	def String getCompletePath(){
		path
	}

}
