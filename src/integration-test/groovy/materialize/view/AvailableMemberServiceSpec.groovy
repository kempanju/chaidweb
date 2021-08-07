package materialize.view

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class AvailableMemberServiceSpec extends Specification {

    AvailableMemberService availableMemberService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new AvailableMember(...).save(flush: true, failOnError: true)
        //new AvailableMember(...).save(flush: true, failOnError: true)
        //AvailableMember availableMember = new AvailableMember(...).save(flush: true, failOnError: true)
        //new AvailableMember(...).save(flush: true, failOnError: true)
        //new AvailableMember(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //availableMember.id
    }

    void "test get"() {
        setupData()

        expect:
        availableMemberService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<AvailableMember> availableMemberList = availableMemberService.list(max: 2, offset: 2)

        then:
        availableMemberList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        availableMemberService.count() == 5
    }

    void "test delete"() {
        Long availableMemberId = setupData()

        expect:
        availableMemberService.count() == 5

        when:
        availableMemberService.delete(availableMemberId)
        sessionFactory.currentSession.flush()

        then:
        availableMemberService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        AvailableMember availableMember = new AvailableMember()
        availableMemberService.save(availableMember)

        then:
        availableMember.id != null
    }
}
