package chaid

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class AdolescentAbuseServiceSpec extends Specification {

    AdolescentAbuseService adolescentAbuseService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new AdolescentAbuse(...).save(flush: true, failOnError: true)
        //new AdolescentAbuse(...).save(flush: true, failOnError: true)
        //AdolescentAbuse adolescentAbuse = new AdolescentAbuse(...).save(flush: true, failOnError: true)
        //new AdolescentAbuse(...).save(flush: true, failOnError: true)
        //new AdolescentAbuse(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //adolescentAbuse.id
    }

    void "test get"() {
        setupData()

        expect:
        adolescentAbuseService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<AdolescentAbuse> adolescentAbuseList = adolescentAbuseService.list(max: 2, offset: 2)

        then:
        adolescentAbuseList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        adolescentAbuseService.count() == 5
    }

    void "test delete"() {
        Long adolescentAbuseId = setupData()

        expect:
        adolescentAbuseService.count() == 5

        when:
        adolescentAbuseService.delete(adolescentAbuseId)
        sessionFactory.currentSession.flush()

        then:
        adolescentAbuseService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        AdolescentAbuse adolescentAbuse = new AdolescentAbuse()
        adolescentAbuseService.save(adolescentAbuse)

        then:
        adolescentAbuse.id != null
    }
}
