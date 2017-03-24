package audites.appModel

import audites.domain.Revision
import audites.domain.User
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class MainApplicationAppModel {
	
	User userLoged
	Revision selectedRevision
	
	new(){}
	
	
}