package materialize.view

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class YearReportsServiceSpec extends Specification {

    YearReportsService yearReportsService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new YearReports(...).save(flush: true, failOnError: true)
        //new YearReports(...).save(flush: true, failOnError: true)
        //YearReports yearReports = new YearReports(...).save(flush: true, failOnError: true)
        //new YearReports(...).save(flush: true, failOnError: true)
        //new YearReports(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //yearReports.id
    }

    void "test get"() {
        setupData()

        expect:
        yearReportsService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<YearReports> yearReportsList = yearReportsService.list(max: 2, offset: 2)

        then:
        yearReportsList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        yearReportsService.count() == 5
    }

    void "test delete"() {
        Long yearReportsId = setupData()

        expect:
        yearReportsService.count() == 5

        when:
        yearReportsService.delete(yearReportsId)
        sessionFactory.currentSession.flush()

        then:
        yearReportsService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        YearReports yearReports = new YearReports()
        yearReportsService.save(yearReports)

        then:
        yearReports.id != null
    }
}
