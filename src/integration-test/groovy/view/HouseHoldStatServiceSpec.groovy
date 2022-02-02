package view

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class HouseHoldStatServiceSpec extends Specification {

    HouseHoldStatService houseHoldStatService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new HouseHoldStat(...).save(flush: true, failOnError: true)
        //new HouseHoldStat(...).save(flush: true, failOnError: true)
        //HouseHoldStat houseHoldStat = new HouseHoldStat(...).save(flush: true, failOnError: true)
        //new HouseHoldStat(...).save(flush: true, failOnError: true)
        //new HouseHoldStat(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //houseHoldStat.id
    }

    void "test get"() {
        setupData()

        expect:
        houseHoldStatService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<HouseHoldStat> houseHoldStatList = houseHoldStatService.list(max: 2, offset: 2)

        then:
        houseHoldStatList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        houseHoldStatService.count() == 5
    }

    void "test delete"() {
        Long houseHoldStatId = setupData()

        expect:
        houseHoldStatService.count() == 5

        when:
        houseHoldStatService.delete(houseHoldStatId)
        sessionFactory.currentSession.flush()

        then:
        houseHoldStatService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        HouseHoldStat houseHoldStat = new HouseHoldStat()
        houseHoldStatService.save(houseHoldStat)

        then:
        houseHoldStat.id != null
    }
}
