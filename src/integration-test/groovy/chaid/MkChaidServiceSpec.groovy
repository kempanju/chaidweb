package chaid

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class MkChaidServiceSpec extends Specification {

    MkChaidService mkChaidService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new MkChaid(...).save(flush: true, failOnError: true)
        //new MkChaid(...).save(flush: true, failOnError: true)
        //MkChaid mkChaid = new MkChaid(...).save(flush: true, failOnError: true)
        //new MkChaid(...).save(flush: true, failOnError: true)
        //new MkChaid(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //mkChaid.id
    }

    void "test get"() {
        setupData()

        expect:
        mkChaidService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<MkChaid> mkChaidList = mkChaidService.list(max: 2, offset: 2)

        then:
        mkChaidList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        mkChaidService.count() == 5
    }

    void "test delete"() {
        Long mkChaidId = setupData()

        expect:
        mkChaidService.count() == 5

        when:
        mkChaidService.delete(mkChaidId)
        sessionFactory.currentSession.flush()

        then:
        mkChaidService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        MkChaid mkChaid = new MkChaid()
        mkChaidService.save(mkChaid)

        then:
        mkChaid.id != null
    }
}
