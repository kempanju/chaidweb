package materialize.view

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class MonthlyReportServiceSpec extends Specification {

    MonthlyReportService monthlyReportService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new MonthlyReport(...).save(flush: true, failOnError: true)
        //new MonthlyReport(...).save(flush: true, failOnError: true)
        //MonthlyReport monthlyReport = new MonthlyReport(...).save(flush: true, failOnError: true)
        //new MonthlyReport(...).save(flush: true, failOnError: true)
        //new MonthlyReport(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //monthlyReport.id
    }

    void "test get"() {
        setupData()

        expect:
        monthlyReportService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<MonthlyReport> monthlyReportList = monthlyReportService.list(max: 2, offset: 2)

        then:
        monthlyReportList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        monthlyReportService.count() == 5
    }

    void "test delete"() {
        Long monthlyReportId = setupData()

        expect:
        monthlyReportService.count() == 5

        when:
        monthlyReportService.delete(monthlyReportId)
        sessionFactory.currentSession.flush()

        then:
        monthlyReportService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        MonthlyReport monthlyReport = new MonthlyReport()
        monthlyReportService.save(monthlyReport)

        then:
        monthlyReport.id != null
    }
}
