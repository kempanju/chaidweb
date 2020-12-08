package chaid

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class FacilityServiceSpec extends Specification {

    FacilityService facilityService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Facility(...).save(flush: true, failOnError: true)
        //new Facility(...).save(flush: true, failOnError: true)
        //Facility facility = new Facility(...).save(flush: true, failOnError: true)
        //new Facility(...).save(flush: true, failOnError: true)
        //new Facility(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //facility.id
    }

    void "test get"() {
        setupData()

        expect:
        facilityService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Facility> facilityList = facilityService.list(max: 2, offset: 2)

        then:
        facilityList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        facilityService.count() == 5
    }

    void "test delete"() {
        Long facilityId = setupData()

        expect:
        facilityService.count() == 5

        when:
        facilityService.delete(facilityId)
        sessionFactory.currentSession.flush()

        then:
        facilityService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Facility facility = new Facility()
        facilityService.save(facility)

        then:
        facility.id != null
    }
}
