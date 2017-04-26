package audites.appModel

import audites.domain.Department
import audites.domain.Revision
import audites.domain.User
import audites.repos.RepoRevisions
import java.io.Serializable
import java.text.SimpleDateFormat
import java.util.Date
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Dependencies
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class AuditorAppModel extends MainApplicationAppModel implements Serializable {
	Revision toSearch = new Revision
	List<Revision> results
	Set<Department> departments = newHashSet()
	Department departmentSelected
	Revision revisionSelected

	new() {
		super()
		departmentSelected = userLoged.departments.head
//		revisionSelected = userLoged.revisions.head
		revisionSelected = if(!userLoged.revisions.empty) userLoged.revisions.head else new Revision
	}

	new(User user) {
		super(user)
		departmentSelected = userLoged.departments.head
//		revisionSelected = userLoged.revisions.head
		revisionSelected = if(!userLoged.revisions.empty) userLoged.revisions.head else new Revision
	}

	@Dependencies("revisionSelected")
	def boolean getRevisionIsNotFinished() {
		revisionSelected != null && !revisionSelected.isCompleted
	}

	@Dependencies("revisionSelected")
	def boolean getRevisionIsSelectedAuditor() {
		revisionSelected != null
	}

	def void setRevisionSearch(String rev) {
		toSearch.name = rev
		search
	}

	def String getRevisionSearch() {
		toSearch.name
	}

	def void search() {
		val searchResults = RepoRevisions.instance.search(toSearch.name)
		results = searchResults.filter[revision|userLoged.revisions.contains(revision) || revision.author == userLoged].
			toList
	}

	def formatDate(Date date) {
		val formatter = new SimpleDateFormat("dd/MM/yyyy")
		formatter.format(date)
	}
}
