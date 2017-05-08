package audites.appModel

import audites.domain.Department
import audites.domain.Requirement
import audites.domain.Revision
import audites.domain.User
import audites.emailSender.NewRevisionMail
import audites.logger.NewRevisionLog
import audites.repos.RepoDepartments
import audites.repos.RepoRequirements
import audites.repos.RepoRevisions
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Dependencies
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class NewRevisionAppModel extends MainApplicationAppModel {

	List<Department> departments
	Revision revision
	Requirement selectedRequirement
	Department selectedDepartment

	new() {
		super()
		departments = RepoDepartments.instance.allInstances
		revision = new Revision
		selectedRequirement = revision.requirements.head
		selectedDepartment = RepoDepartments.instance.allInstances.head
	}

	new(User user) {
		super(user)
		departments = RepoDepartments.instance.allInstances
		revision = new Revision
		selectedRequirement = revision.requirements.head
		selectedDepartment = RepoDepartments.instance.allInstances.head
	}

	new(Requirement requirement, Revision revision) {
		super()
		departments = RepoDepartments.instance.allInstances
		this.revision = revision
		this.selectedRequirement = requirement
		selectedDepartment = RepoDepartments.instance.allInstances.head
	}

	new(Revision revision) {
		super()
		departments = RepoDepartments.instance.allInstances
		this.revision = revision
		selectedRequirement = new Requirement
		selectedDepartment = RepoDepartments.instance.allInstances.head
	}

	new(Revision revision, User user) {
		super(user)
		departments = RepoDepartments.instance.allInstances
		this.revision = revision
		selectedRequirement = revision.requirements.head
		selectedDepartment = RepoDepartments.instance.allInstances.head
	}

	def List<Department> getDepartments() {
		var list = newArrayList()
		val allDep = RepoDepartments.instance.allInstances
		for (Department d : allDep) {
			if (!list.contains(d) && d.name != "") {
				list.add(d)
			}
		}
		return list
	}

	def void setSelectedDepartment(Department dep) {
		if (selectedDepartment != null) {
			selectedDepartment.removeRevision(revision)
		}

		selectedDepartment = dep
		selectedDepartment.addRevision(revision)
		revision.responsable = selectedDepartment
		revision.attendant = selectedDepartment.maxAuthority
	}

	def getEditRevisionDepartment() { revision.responsable }

	def void setEditRevisionDepartment(Department dep) {
		if (selectedDepartment != null) {
			revision.responsable.removeRevision(revision)
			RepoDepartments.instance.update(revision.responsable)
		}

		selectedDepartment = dep
		selectedDepartment.addRevision(revision)
		revision.responsable = selectedDepartment
		revision.attendant = selectedDepartment.maxAuthority
		RepoDepartments.instance.update(revision.responsable)
		RepoRevisions.instance.update(revision)
	}

	override getMailer() {
		new NewRevisionMail(userLoged, revision.responsable.maxAuthority, revision)
	}

	override getLogger() {
		new NewRevisionLog(userLoged, revision)
	}

	@Dependencies("selectedRequirement")
	def boolean getHasRequirements() {
		selectedRequirement != null && !selectedRequirement.isCompleted
	}

	def void setSelectedRequirement(Requirement req) {
		selectedRequirement = req
		ObservableUtils.firePropertyChanged(this, "selectedRequirement")
	}

	def Requirement getSelectedRequirement() {
		selectedRequirement
	}

	@Dependencies("selectedDepartment")
	def boolean getDepartmentIngresed() {
		selectedDepartment != null
	}

	def String getRevisionName() {
		this.revision.name
	}

	def void setRevisionName(String name) {
		revision.name = name
		RepoRevisions.instance.update(revision)
	}

	def String getRevisionComment() {
		this.revision.description
	}

	def void setRevisionComment(String comment) {
		revision.description = comment
		RepoRevisions.instance.update(revision)
	}

	def String getRequirementComments() {
		this.selectedRequirement.comments
	}

	def void setRequirementComments(String s) {
		selectedRequirement.comments = s
		RepoRequirements.instance.update(selectedRequirement)
		RepoRevisions.instance.update(revision)
	}

	def createRevison() {
		revision.author = userLoged
		revision.responsable = selectedDepartment
		revision.attendant = selectedDepartment.maxAuthority
		userLoged.revisions.add(revision)
		selectedDepartment.addRevision(revision)
		RepoRevisions.instance.create(revision)
		RepoDepartments.instance.update(selectedDepartment)
	}

	def logAndNotify() {
		logger.write()
	// mailer.sendEmail()
	}

	def validateRevision() {
		if (revision.name == "") {
			throw new UserException("Ingresa el nombre de la revision.")
		}
		if (selectedDepartment == null) {
			throw new UserException("Ingresa un departamento.")
		}

		validateRequirements()
	}

	def validateRevisionName() {
		if(!RepoRevisions.instance.searchByName(revision.name).empty) throw new UserException(
			"Ya existe una revision con ese nombre.")
	}

	def deleteRequirement() {
		RepoRequirements.instance.remove(selectedRequirement, revision)
	}

	def validateRequirements() {
		if(revision.requirements.size == 0) throw new UserException("Debe ingresar al menos un requerimiento.")
	}

}
