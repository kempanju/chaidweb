package chaid

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class DangerSignPregnantServiceSpec extends Specification {

    DangerSignPregnantService dangerSignPregnantService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new DangerSignPregnant(...).save(flush: true, failOnError: true)
        //new DangerSignPregnant(...).save(flush: true, failOnError: true)
        //DangerSignPregnant dangerSignPregnant = new DangerSignPregnant(...).save(flush: true, failOnError: true)
        //new DangerSignPregnant(...).save(flush: true, failOnError: true)
        //new DangerSignPregnant(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //dangerSignPregnant.id
    }

    void "test get"() {
        setupData()

        expect:
        dangerSignPregnantService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<DangerSignPregnant> dangerSignPregnantList = dangerSignPregnantService.list(max: 2, offset: 2)

        then:
        dangerSignPregnantList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        dangerSignPregnantService.count() == 5
    }

    void "test delete"() {
        Long dangerSignPregnantId = setupData()

        expect:
        dangerSignPregnantService.count() == 5

        when:
        dangerSignPregnantService.delete(dangerSignPregnantId)
        sessionFactory.currentSession.flush()

        then:
        dangerSignPregnantService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        DangerSignPregnant dangerSignPregnant = new DangerSignPregnant()
        dangerSignPregnantService.save(dangerSignPregnant)

        then:
        dangerSignPregnant.id != null
    }
}
