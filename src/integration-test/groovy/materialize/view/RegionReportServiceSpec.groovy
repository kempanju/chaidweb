package materialize.view

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class RegionReportServiceSpec extends Specification {

    RegionReportService regionReportService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new RegionReport(...).save(flush: true, failOnError: true)
        //new RegionReport(...).save(flush: true, failOnError: true)
        //RegionReport regionReport = new RegionReport(...).save(flush: true, failOnError: true)
        //new RegionReport(...).save(flush: true, failOnError: true)
        //new RegionReport(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //regionReport.id
    }

    void "test get"() {
        setupData()

        expect:
        regionReportService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<RegionReport> regionReportList = regionReportService.list(max: 2, offset: 2)

        then:
        regionReportList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        regionReportService.count() == 5
    }

    void "test delete"() {
        Long regionReportId = setupData()

        expect:
        regionReportService.count() == 5

        when:
        regionReportService.delete(regionReportId)
        sessionFactory.currentSession.flush()

        then:
        regionReportService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        RegionReport regionReport = new RegionReport()
        regionReportService.save(regionReport)

        then:
        regionReport.id != null
    }
}
