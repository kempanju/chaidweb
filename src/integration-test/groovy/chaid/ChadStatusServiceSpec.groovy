package chaid

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class ChadStatusServiceSpec extends Specification {

    ChadStatusService chadStatusService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new ChadStatus(...).save(flush: true, failOnError: true)
        //new ChadStatus(...).save(flush: true, failOnError: true)
        //ChadStatus chadStatus = new ChadStatus(...).save(flush: true, failOnError: true)
        //new ChadStatus(...).save(flush: true, failOnError: true)
        //new ChadStatus(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //chadStatus.id
    }

    void "test get"() {
        setupData()

        expect:
        chadStatusService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<ChadStatus> chadStatusList = chadStatusService.list(max: 2, offset: 2)

        then:
        chadStatusList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        chadStatusService.count() == 5
    }

    void "test delete"() {
        Long chadStatusId = setupData()

        expect:
        chadStatusService.count() == 5

        when:
        chadStatusService.delete(chadStatusId)
        sessionFactory.currentSession.flush()

        then:
        chadStatusService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        ChadStatus chadStatus = new ChadStatus()
        chadStatusService.save(chadStatus)

        then:
        chadStatus.id != null
    }
}
