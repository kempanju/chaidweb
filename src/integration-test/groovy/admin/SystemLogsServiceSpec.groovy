package admin

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class SystemLogsServiceSpec extends Specification {

    SystemLogsService systemLogsService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new SystemLogs(...).save(flush: true, failOnError: true)
        //new SystemLogs(...).save(flush: true, failOnError: true)
        //SystemLogs systemLogs = new SystemLogs(...).save(flush: true, failOnError: true)
        //new SystemLogs(...).save(flush: true, failOnError: true)
        //new SystemLogs(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //systemLogs.id
    }

    void "test get"() {
        setupData()

        expect:
        systemLogsService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<SystemLogs> systemLogsList = systemLogsService.list(max: 2, offset: 2)

        then:
        systemLogsList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        systemLogsService.count() == 5
    }

    void "test delete"() {
        Long systemLogsId = setupData()

        expect:
        systemLogsService.count() == 5

        when:
        systemLogsService.delete(systemLogsId)
        sessionFactory.currentSession.flush()

        then:
        systemLogsService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        SystemLogs systemLogs = new SystemLogs()
        systemLogsService.save(systemLogs)

        then:
        systemLogs.id != null
    }
}
