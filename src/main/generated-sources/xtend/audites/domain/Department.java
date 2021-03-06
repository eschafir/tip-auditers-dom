package audites.domain;

import audites.domain.Revision;
import audites.domain.User;
import audites.repos.RepoUsers;
import java.util.List;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.Pure;
import org.uqbar.commons.utils.Observable;

@Observable
@Accessors
@Entity
@SuppressWarnings("all")
public class Department {
  @Id
  @GeneratedValue
  private Long id;
  
  @Column(length = 100)
  private String name;
  
  @Column(length = 100)
  private String email;
  
  @ManyToMany(fetch = FetchType.LAZY)
  private Set<Revision> revisions = CollectionLiterals.<Revision>newHashSet();
  
  @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
  private User maxAuthority;
  
  public Department() {
    this.name = "";
    this.email = "";
    this.maxAuthority = null;
  }
  
  public void addRevision(final Revision rev) {
    boolean _contains = this.revisions.contains(rev);
    boolean _not = (!_contains);
    if (_not) {
      this.revisions.add(rev);
    }
  }
  
  public void removeRevision(final Revision rev) {
    boolean _contains = this.revisions.contains(rev);
    if (_contains) {
      this.revisions.remove(rev);
    }
  }
  
  public List<User> getObtainUsers() {
    RepoUsers _instance = RepoUsers.getInstance();
    List<User> _allInstances = _instance.allInstances();
    final Function1<User, Boolean> _function = new Function1<User, Boolean>() {
      public Boolean apply(final User user) {
        List<Department> _departments = user.getDepartments();
        return Boolean.valueOf(_departments.contains(Department.this));
      }
    };
    Iterable<User> _filter = IterableExtensions.<User>filter(_allInstances, _function);
    return IterableExtensions.<User>toList(_filter);
  }
  
  @Pure
  public Long getId() {
    return this.id;
  }
  
  public void setId(final Long id) {
    this.id = id;
  }
  
  @Pure
  public String getName() {
    return this.name;
  }
  
  public void setName(final String name) {
    this.name = name;
  }
  
  @Pure
  public String getEmail() {
    return this.email;
  }
  
  public void setEmail(final String email) {
    this.email = email;
  }
  
  @Pure
  public Set<Revision> getRevisions() {
    return this.revisions;
  }
  
  public void setRevisions(final Set<Revision> revisions) {
    this.revisions = revisions;
  }
  
  @Pure
  public User getMaxAuthority() {
    return this.maxAuthority;
  }
  
  public void setMaxAuthority(final User maxAuthority) {
    this.maxAuthority = maxAuthority;
  }
}
