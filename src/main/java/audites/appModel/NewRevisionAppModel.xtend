package audites.appModel

import audites.domain.Department
import audites.domain.Evidence
import audites.domain.Requirement
import audites.domain.Revision
import audites.domain.User
import audites.logger.Logger
import audites.repos.RepoDepartments
import audites.repos.RepoRequirements
import audites.repos.RepoRevisions
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Dependencies
import org.uqbar.commons.utils.Observable
import audites.emailSender.NewRevisionMail

@Observable
@Accessors
class NewRevisionAppModel extends MainApplicationAppModel {

	List<Department> departments
	Revision revision
	Requirement selectedRequirement
	Department selectedDepartment
	String selectedFile
	

	new() {
		super()
		departments = RepoDepartments.instance.allInstances
		revision = new Revision
		selectedRequirement = revision.requirements.head
		selectedDepartment = RepoDepartments.instance.allInstances.head
		selectedFile = ""
	}

	new(User user) {
		super(user)
		departments = RepoDepartments.instance.allInstances
		revision = new Revision
		selectedRequirement = revision.requirements.head
		selectedDepartment = RepoDepartments.instance.allInstances.head
		selectedFile = ""
	}

	new(Requirement requirement, Revision revision) {
		super()
		departments = RepoDepartments.instance.allInstances
		this.revision = revision
		this.selectedRequirement = requirement
		selectedDepartment = RepoDepartments.instance.allInstances.head
		selectedFile = ""
	}

	new(Revision revision) {
		super()
		departments = RepoDepartments.instance.allInstances
		this.revision = revision
		selectedRequirement = new Requirement
		selectedDepartment = RepoDepartments.instance.allInstances.head
		selectedFile = ""
	}

	new(Revision revision, User user) {
		super(user)
		departments = RepoDepartments.instance.allInstances
		this.revision = revision
		selectedRequirement = revision.requirements.head
		selectedDepartment = RepoDepartments.instance.allInstances.head
		selectedFile = ""
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

	def void setSelectedRequirement(Requirement req) {
		selectedRequirement = req
		ObservableUtils.firePropertyChanged(this, "selectedRequirement")
	}

	def Requirement getSelectedRequirement() {
		selectedRequirement
	}

	def void setSelectedFile(String s) {
		selectedFile = s
		selectedRequirement.addEvidence(new Evidence(selectedFile))
		RepoRequirements.instance.update(selectedRequirement)
		RepoRevisions.instance.update(revision)
	}
	
	override getMailer() {
		new NewRevisionMail(revision)
	}

	@Dependencies("selectedRequirement")
	def boolean getHasRequirements() {
		/**
		 * Con esta linea se grisan las 2 opciones de Editar y Eliminar, pero al eliminar un requerimiento
		 * la aplicacion da un RuntimeException
		 */
		// selectedRequirement.name != ""
		selectedRequirement != null
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
		Logger.write(userLoged.name + " ha generado la revision: " + revision.name)
		mailer.sendEmail(userLoged, selectedDepartment.maxAuthority)
	}

	def deleteRequirement() {
		Logger.write(userLoged.name + " ha eliminado el requerimiento: " + selectedRequirement.name)
		RepoRequirements.instance.remove(selectedRequirement, revision)
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

	def validateRequirements() {
		if(revision.requirements.size == 0) throw new UserException("Debe ingresar al menos un requerimiento.")
	}

}
