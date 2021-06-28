package models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Table(name="follows")

@NamedQueries({
    @NamedQuery(name = "followDestroy",
                query = "SELECT f.id FROM Follow AS f WHERE f.follow  = :follow"),
    @NamedQuery(name = "getMyFollowReports",
                query = "SELECT r FROM Report AS r WHERE r.employee = :employee ORDER BY r.id DESC"),
    @NamedQuery(name = "getMyFollowReportsCount",
                query = "SELECT COUNT(r) FROM Report AS r WHERE r.employee = :employee"),
    @NamedQuery(name = "getMyAllFollows",
                query = "SELECT f FROM Employee AS e, Follow AS f WHERE f.employee = :employee AND e.id = f.follow.id ORDER BY f.id DESC"),
    @NamedQuery(name = "getMyFollowsCount",
                query = "SELECT COUNT(f) FROM Employee AS e, Follow AS f WHERE f.employee = :employee AND e.id = f.follow.id")
})

@Entity
public class Follow {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "employee_id", nullable = false)
    private Employee employee;



    @ManyToOne
    @JoinColumn(name = "follow_id", nullable = false)
    private Employee follow;



    public Integer getId() {
        return id;
    }



    public void setId(Integer id) {
        this.id = id;
    }



    public Employee getEmployee() {
        return employee;
    }



    public void setEmployee(Employee employee) {
        this.employee = employee;
    }



    public Employee getFollow() {
        return follow;
    }



    public void setFollow(Employee follow) {
        this.follow = follow;
    }

}


