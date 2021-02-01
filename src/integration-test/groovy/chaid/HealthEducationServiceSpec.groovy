package chaid

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class HealthEducationServiceSpec extends Specification {

    HealthEducationService healthEducationService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new HealthEducation(...).save(flush: true, failOnError: true)
        //new HealthEducation(...).save(flush: true, failOnError: true)
        //HealthEducation healthEducation = new HealthEducation(...).save(flush: true, failOnError: true)
        //new HealthEducation(...).save(flush: true, failOnError: true)
        //new HealthEducation(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //healthEducation.id
    }

    void "test get"() {
        setupData()

        expect:
        healthEducationService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<HealthEducation> healthEducationList = healthEducationService.list(max: 2, offset: 2)

        then:
        healthEducationList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        healthEducationService.count() == 5
    }

    void "test delete"() {
        Long healthEducationId = setupData()

        expect:
        healthEducationService.count() == 5

        when:
        healthEducationService.delete(healthEducationId)
        sessionFactory.currentSession.flush()

        then:
        healthEducationService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        HealthEducation healthEducation = new HealthEducation()
        healthEducationService.save(healthEducation)

        then:
        healthEducation.id != null
    }
}
