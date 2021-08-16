package materialize.view

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class DangerSignServiceSpec extends Specification {

    DangerSignService dangerSignService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new DangerSign(...).save(flush: true, failOnError: true)
        //new DangerSign(...).save(flush: true, failOnError: true)
        //DangerSign dangerSign = new DangerSign(...).save(flush: true, failOnError: true)
        //new DangerSign(...).save(flush: true, failOnError: true)
        //new DangerSign(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //dangerSign.id
    }

    void "test get"() {
        setupData()

        expect:
        dangerSignService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<DangerSign> dangerSignList = dangerSignService.list(max: 2, offset: 2)

        then:
        dangerSignList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        dangerSignService.count() == 5
    }

    void "test delete"() {
        Long dangerSignId = setupData()

        expect:
        dangerSignService.count() == 5

        when:
        dangerSignService.delete(dangerSignId)
        sessionFactory.currentSession.flush()

        then:
        dangerSignService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        DangerSign dangerSign = new DangerSign()
        dangerSignService.save(dangerSign)

        then:
        dangerSign.id != null
    }
}
