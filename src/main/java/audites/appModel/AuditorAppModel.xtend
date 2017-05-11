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
import java.text.DecimalFormat

@Observable
@Accessors
class AuditorAppModel extends MainApplicationAppModel implements Serializable {
	Revision toSearch = new Revision
	List<Revision> results
	Set<Department> departments = newHashSet()
	Department departmentSelected
	Revision revisionSelected
	Boolean withArchivedRevisions = false

	new() {
		super()
		departmentSelected = userLoged.departments.head
		revisionSelected = null

	}

	new(User user) {
		super(user)
		departmentSelected = userLoged.departments.head
		revisionSelected = null
	}

	@Dependencies("revisionSelected")
	def boolean getRevisionIsNotFinished() {
		revisionSelected != null && !revisionSelected.isCompleted
	}

	@Dependencies("revisionSelected")
	def boolean getRevisionIsSelectedAuditor() {
		revisionSelected != null
	}

	@Dependencies("revisionSelected")
	def boolean getRevisionCompletedAndAsigned() {
		revisionSelected != null && revisionSelected.isCompleted && !revisionSelected.archived &&
			revisionSelected.attendant == userLoged
	}

	def void setRevisionSearch(String rev) {
		toSearch.name = rev
		search
	}

	def String getRevisionSearch() {
		toSearch.name
	}

	def void search() {
		val searchResults = RepoRevisions.instance.searchByExample(toSearch)
		results = searchResults.filter[revision|userLoged.revisions.contains(revision) || revision.author == userLoged].
			toList
	}

	def formatDate(Date date) {
		val formatter = new SimpleDateFormat("dd/MM/yyyy")
		formatter.format(date)
	}

	def formatAverage(Float avg) {
		if (avg == 1.00 || avg == 0.00)
			new DecimalFormat("#0" + " %").format(avg)
		else
			new DecimalFormat("#0.00" + " %").format(avg)
	}

	def archive() {
		revisionSelected.archived = true
		RepoRevisions.instance.update(revisionSelected)
		search
	}

	def Boolean getWithArchivedRevisions() {
		withArchivedRevisions
	}

	def void setWithArchivedRevisions(Boolean b) {
		toSearch.archived = b
		withArchivedRevisions = b
		search
	}
}
