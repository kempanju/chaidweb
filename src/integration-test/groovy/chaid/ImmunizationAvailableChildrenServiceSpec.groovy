package chaid

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class ImmunizationAvailableChildrenServiceSpec extends Specification {

    ImmunizationAvailableChildrenService immunizationAvailableChildrenService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new ImmunizationAvailableChildren(...).save(flush: true, failOnError: true)
        //new ImmunizationAvailableChildren(...).save(flush: true, failOnError: true)
        //ImmunizationAvailableChildren immunizationAvailableChildren = new ImmunizationAvailableChildren(...).save(flush: true, failOnError: true)
        //new ImmunizationAvailableChildren(...).save(flush: true, failOnError: true)
        //new ImmunizationAvailableChildren(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //immunizationAvailableChildren.id
    }

    void "test get"() {
        setupData()

        expect:
        immunizationAvailableChildrenService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<ImmunizationAvailableChildren> immunizationAvailableChildrenList = immunizationAvailableChildrenService.list(max: 2, offset: 2)

        then:
        immunizationAvailableChildrenList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        immunizationAvailableChildrenService.count() == 5
    }

    void "test delete"() {
        Long immunizationAvailableChildrenId = setupData()

        expect:
        immunizationAvailableChildrenService.count() == 5

        when:
        immunizationAvailableChildrenService.delete(immunizationAvailableChildrenId)
        sessionFactory.currentSession.flush()

        then:
        immunizationAvailableChildrenService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        ImmunizationAvailableChildren immunizationAvailableChildren = new ImmunizationAvailableChildren()
        immunizationAvailableChildrenService.save(immunizationAvailableChildren)

        then:
        immunizationAvailableChildren.id != null
    }
}
