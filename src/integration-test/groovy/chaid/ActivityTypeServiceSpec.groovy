package chaid

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class ActivityTypeServiceSpec extends Specification {

    ActivityTypeService activityTypeService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new ActivityType(...).save(flush: true, failOnError: true)
        //new ActivityType(...).save(flush: true, failOnError: true)
        //ActivityType activityType = new ActivityType(...).save(flush: true, failOnError: true)
        //new ActivityType(...).save(flush: true, failOnError: true)
        //new ActivityType(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //activityType.id
    }

    void "test get"() {
        setupData()

        expect:
        activityTypeService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<ActivityType> activityTypeList = activityTypeService.list(max: 2, offset: 2)

        then:
        activityTypeList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        activityTypeService.count() == 5
    }

    void "test delete"() {
        Long activityTypeId = setupData()

        expect:
        activityTypeService.count() == 5

        when:
        activityTypeService.delete(activityTypeId)
        sessionFactory.currentSession.flush()

        then:
        activityTypeService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        ActivityType activityType = new ActivityType()
        activityTypeService.save(activityType)

        then:
        activityType.id != null
    }
}
