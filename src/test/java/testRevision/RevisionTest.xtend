package testRevision

import audites.domain.Revision
import audites.domain.Requirement
import audites.domain.States.RequirementState.RequirementState
import org.junit.Before
import audites.domain.States.RequirementState.Completado
import org.junit.Test
import static org.junit.Assert.*;
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class RevisionTest {
	Revision revision
	Requirement requirement1
	Requirement requirement2
	Requirement requirement3
	Requirement requirement4
	RequirementState completed

	@Before
	def void setUp() {
		revision = new Revision
		requirement1 = new Requirement("Req. 1", "")
		requirement2 = new Requirement("Req. 2", "")
		requirement3 = new Requirement("Req. 3", "")
		requirement4 = new Requirement("Req. 4", "")
		completed = new Completado

	}

	@Test
	def void testCompletedRequirements() {
		requirement1.setRequirementState(completed)
		requirement2.setRequirementState(completed)
		revision.addRequirement(requirement1)
		revision.addRequirement(requirement2)
		assertEquals(revision.completedRequirements, 2)
	}
}
