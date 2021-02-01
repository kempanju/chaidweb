package chaid

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class ChildUnderFiveImmunizationServiceSpec extends Specification {

    ChildUnderFiveImmunizationService childUnderFiveImmunizationService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new ChildUnderFiveImmunization(...).save(flush: true, failOnError: true)
        //new ChildUnderFiveImmunization(...).save(flush: true, failOnError: true)
        //ChildUnderFiveImmunization childUnderFiveImmunization = new ChildUnderFiveImmunization(...).save(flush: true, failOnError: true)
        //new ChildUnderFiveImmunization(...).save(flush: true, failOnError: true)
        //new ChildUnderFiveImmunization(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //childUnderFiveImmunization.id
    }

    void "test get"() {
        setupData()

        expect:
        childUnderFiveImmunizationService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<ChildUnderFiveImmunization> childUnderFiveImmunizationList = childUnderFiveImmunizationService.list(max: 2, offset: 2)

        then:
        childUnderFiveImmunizationList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        childUnderFiveImmunizationService.count() == 5
    }

    void "test delete"() {
        Long childUnderFiveImmunizationId = setupData()

        expect:
        childUnderFiveImmunizationService.count() == 5

        when:
        childUnderFiveImmunizationService.delete(childUnderFiveImmunizationId)
        sessionFactory.currentSession.flush()

        then:
        childUnderFiveImmunizationService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        ChildUnderFiveImmunization childUnderFiveImmunization = new ChildUnderFiveImmunization()
        childUnderFiveImmunizationService.save(childUnderFiveImmunization)

        then:
        childUnderFiveImmunization.id != null
    }
}
