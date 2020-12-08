package admin

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class SubStreetServiceSpec extends Specification {

    SubStreetService subStreetService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new SubStreet(...).save(flush: true, failOnError: true)
        //new SubStreet(...).save(flush: true, failOnError: true)
        //SubStreet subStreet = new SubStreet(...).save(flush: true, failOnError: true)
        //new SubStreet(...).save(flush: true, failOnError: true)
        //new SubStreet(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //subStreet.id
    }

    void "test get"() {
        setupData()

        expect:
        subStreetService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<SubStreet> subStreetList = subStreetService.list(max: 2, offset: 2)

        then:
        subStreetList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        subStreetService.count() == 5
    }

    void "test delete"() {
        Long subStreetId = setupData()

        expect:
        subStreetService.count() == 5

        when:
        subStreetService.delete(subStreetId)
        sessionFactory.currentSession.flush()

        then:
        subStreetService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        SubStreet subStreet = new SubStreet()
        subStreetService.save(subStreet)

        then:
        subStreet.id != null
    }
}
