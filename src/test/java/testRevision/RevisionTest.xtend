package testRevision

import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Before
import audites.domain.Requirement
import org.junit.Test

@Accessors
class RevisionTest {

	Requirement requirement1
	Requirement requirement2
	Requirement requirement3
	Requirement requirement4

	@Before
	def void setUp() {
		requirement1 = new Requirement("Req. 1", "")
		requirement2 = new Requirement("Req. 2", "")
		requirement3 = new Requirement("Req. 3", "")
		requirement4 = new Requirement("Req. 4", "")

	}
	
	@Test
	def void testCompletedRequirements() {
		

	}
}
