package audites.appModel

import audites.appModel.NewRevisionAppModel
import audites.domain.Revision
import audites.domain.User
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.ObservableUtils

@Observable
@Accessors
class CheckOrAttendRevisionAppModel extends NewRevisionAppModel {
	String departmentComments
	String filePath

	new(Revision revision, User user) {
		super(revision, user)
		departmentComments = ""
		filePath = ""
	}

	def void setFilePath(String path) {
		filePath = path
		ObservableUtils.firePropertyChanged(this, "filePath")
	}

	def String getFilePath() {
		filePath
	}

}
