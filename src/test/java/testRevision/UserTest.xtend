package testRevision

import org.eclipse.xtend.lib.annotations.Accessors
import audites.domain.Department
import audites.domain.Revision
import org.junit.Before
import org.junit.Test
import audites.domain.User
import static org.junit.Assert.*

@Accessors
class UserTest {

	User user
	Department seginf
	Department internalAudit
	Revision revision1
	Revision revision2

	@Before
	def void setUp() {
		user = new User("Esteban", "123", "eschafir")
		revision2 = new Revision
		seginf = new Department
		internalAudit = new Department
	}

	@Test
	def void testRevisions() {
		seginf.addRevision(revision1)
		internalAudit.addRevision(revision2)
		user.addDepartment(seginf)
		user.addDepartment(internalAudit)
		assertEquals(user.revisions.size,2)
		
	}
	
	@Test
	def void testIsMaximumResponsable(){
		val user1 = new User("pepe","123","pepe@gmail.com")
		val user2 = new User("lolo","123","lolo@gmail.com")
		seginf.maxAuthority = user1
		assertTrue(user1.maximumResponsable(seginf))
		assertFalse(user2.maximumResponsable(seginf))
	}

}
