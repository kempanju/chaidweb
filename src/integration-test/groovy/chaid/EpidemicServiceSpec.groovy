package chaid

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class EpidemicServiceSpec extends Specification {

    EpidemicService epidemicService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Epidemic(...).save(flush: true, failOnError: true)
        //new Epidemic(...).save(flush: true, failOnError: true)
        //Epidemic epidemic = new Epidemic(...).save(flush: true, failOnError: true)
        //new Epidemic(...).save(flush: true, failOnError: true)
        //new Epidemic(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //epidemic.id
    }

    void "test get"() {
        setupData()

        expect:
        epidemicService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Epidemic> epidemicList = epidemicService.list(max: 2, offset: 2)

        then:
        epidemicList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        epidemicService.count() == 5
    }

    void "test delete"() {
        Long epidemicId = setupData()

        expect:
        epidemicService.count() == 5

        when:
        epidemicService.delete(epidemicId)
        sessionFactory.currentSession.flush()

        then:
        epidemicService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Epidemic epidemic = new Epidemic()
        epidemicService.save(epidemic)

        then:
        epidemic.id != null
    }
}
