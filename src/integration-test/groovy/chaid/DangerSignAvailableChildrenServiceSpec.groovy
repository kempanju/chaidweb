package chaid

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class DangerSignAvailableChildrenServiceSpec extends Specification {

    DangerSignAvailableChildrenService dangerSignAvailableChildrenService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new DangerSignAvailableChildren(...).save(flush: true, failOnError: true)
        //new DangerSignAvailableChildren(...).save(flush: true, failOnError: true)
        //DangerSignAvailableChildren dangerSignAvailableChildren = new DangerSignAvailableChildren(...).save(flush: true, failOnError: true)
        //new DangerSignAvailableChildren(...).save(flush: true, failOnError: true)
        //new DangerSignAvailableChildren(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //dangerSignAvailableChildren.id
    }

    void "test get"() {
        setupData()

        expect:
        dangerSignAvailableChildrenService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<DangerSignAvailableChildren> dangerSignAvailableChildrenList = dangerSignAvailableChildrenService.list(max: 2, offset: 2)

        then:
        dangerSignAvailableChildrenList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        dangerSignAvailableChildrenService.count() == 5
    }

    void "test delete"() {
        Long dangerSignAvailableChildrenId = setupData()

        expect:
        dangerSignAvailableChildrenService.count() == 5

        when:
        dangerSignAvailableChildrenService.delete(dangerSignAvailableChildrenId)
        sessionFactory.currentSession.flush()

        then:
        dangerSignAvailableChildrenService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        DangerSignAvailableChildren dangerSignAvailableChildren = new DangerSignAvailableChildren()
        dangerSignAvailableChildrenService.save(dangerSignAvailableChildren)

        then:
        dangerSignAvailableChildren.id != null
    }
}
