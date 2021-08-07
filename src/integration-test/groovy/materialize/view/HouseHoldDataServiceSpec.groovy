package materialize.view

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class HouseHoldDataServiceSpec extends Specification {

    HouseHoldDataService houseHoldDataService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new HouseHoldData(...).save(flush: true, failOnError: true)
        //new HouseHoldData(...).save(flush: true, failOnError: true)
        //HouseHoldData houseHoldData = new HouseHoldData(...).save(flush: true, failOnError: true)
        //new HouseHoldData(...).save(flush: true, failOnError: true)
        //new HouseHoldData(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //houseHoldData.id
    }

    void "test get"() {
        setupData()

        expect:
        houseHoldDataService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<HouseHoldData> houseHoldDataList = houseHoldDataService.list(max: 2, offset: 2)

        then:
        houseHoldDataList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        houseHoldDataService.count() == 5
    }

    void "test delete"() {
        Long houseHoldDataId = setupData()

        expect:
        houseHoldDataService.count() == 5

        when:
        houseHoldDataService.delete(houseHoldDataId)
        sessionFactory.currentSession.flush()

        then:
        houseHoldDataService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        HouseHoldData houseHoldData = new HouseHoldData()
        houseHoldDataService.save(houseHoldData)

        then:
        houseHoldData.id != null
    }
}
