package materialize.view

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class ChaidMeetingTypeServiceSpec extends Specification {

    ChaidMeetingTypeService chaidMeetingTypeService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new ChaidMeetingType(...).save(flush: true, failOnError: true)
        //new ChaidMeetingType(...).save(flush: true, failOnError: true)
        //ChaidMeetingType chaidMeetingType = new ChaidMeetingType(...).save(flush: true, failOnError: true)
        //new ChaidMeetingType(...).save(flush: true, failOnError: true)
        //new ChaidMeetingType(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //chaidMeetingType.id
    }

    void "test get"() {
        setupData()

        expect:
        chaidMeetingTypeService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<ChaidMeetingType> chaidMeetingTypeList = chaidMeetingTypeService.list(max: 2, offset: 2)

        then:
        chaidMeetingTypeList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        chaidMeetingTypeService.count() == 5
    }

    void "test delete"() {
        Long chaidMeetingTypeId = setupData()

        expect:
        chaidMeetingTypeService.count() == 5

        when:
        chaidMeetingTypeService.delete(chaidMeetingTypeId)
        sessionFactory.currentSession.flush()

        then:
        chaidMeetingTypeService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        ChaidMeetingType chaidMeetingType = new ChaidMeetingType()
        chaidMeetingTypeService.save(chaidMeetingType)

        then:
        chaidMeetingType.id != null
    }
}
