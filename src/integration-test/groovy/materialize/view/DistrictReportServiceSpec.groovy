package materialize.view

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class DistrictReportServiceSpec extends Specification {

    DistrictReportService districtReportService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new DistrictReport(...).save(flush: true, failOnError: true)
        //new DistrictReport(...).save(flush: true, failOnError: true)
        //DistrictReport districtReport = new DistrictReport(...).save(flush: true, failOnError: true)
        //new DistrictReport(...).save(flush: true, failOnError: true)
        //new DistrictReport(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //districtReport.id
    }

    void "test get"() {
        setupData()

        expect:
        districtReportService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<DistrictReport> districtReportList = districtReportService.list(max: 2, offset: 2)

        then:
        districtReportList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        districtReportService.count() == 5
    }

    void "test delete"() {
        Long districtReportId = setupData()

        expect:
        districtReportService.count() == 5

        when:
        districtReportService.delete(districtReportId)
        sessionFactory.currentSession.flush()

        then:
        districtReportService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        DistrictReport districtReport = new DistrictReport()
        districtReportService.save(districtReport)

        then:
        districtReport.id != null
    }
}
