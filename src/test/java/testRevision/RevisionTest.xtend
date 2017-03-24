package testRevision

import audites.domain.Requirement
import audites.domain.Revision
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Before
import org.junit.Test

import static org.junit.Assert.*

@Accessors
class RevisionTest {
	Revision revision
	Requirement requirement1
	Requirement requirement2
	Requirement requirement3
	Requirement requirement4

	@Before
	def void setUp() {
		revision = new Revision
		requirement1 = new Requirement("Req. 1", "")
		requirement2 = new Requirement("Req. 2", "")
		requirement3 = new Requirement("Req. 3", "")
		requirement4 = new Requirement("Req. 4", "")

	}

	@Test
	def void testCompletedRequirements() {
		revision.addRequirement(requirement1)
		revision.addRequirement(requirement2)
		assertEquals(revision.completedRequirements, 0)
	}
}
