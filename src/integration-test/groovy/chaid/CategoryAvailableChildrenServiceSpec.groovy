package chaid

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class CategoryAvailableChildrenServiceSpec extends Specification {

    CategoryAvailableChildrenService categoryAvailableChildrenService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new CategoryAvailableChildren(...).save(flush: true, failOnError: true)
        //new CategoryAvailableChildren(...).save(flush: true, failOnError: true)
        //CategoryAvailableChildren categoryAvailableChildren = new CategoryAvailableChildren(...).save(flush: true, failOnError: true)
        //new CategoryAvailableChildren(...).save(flush: true, failOnError: true)
        //new CategoryAvailableChildren(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //categoryAvailableChildren.id
    }

    void "test get"() {
        setupData()

        expect:
        categoryAvailableChildrenService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<CategoryAvailableChildren> categoryAvailableChildrenList = categoryAvailableChildrenService.list(max: 2, offset: 2)

        then:
        categoryAvailableChildrenList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        categoryAvailableChildrenService.count() == 5
    }

    void "test delete"() {
        Long categoryAvailableChildrenId = setupData()

        expect:
        categoryAvailableChildrenService.count() == 5

        when:
        categoryAvailableChildrenService.delete(categoryAvailableChildrenId)
        sessionFactory.currentSession.flush()

        then:
        categoryAvailableChildrenService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        CategoryAvailableChildren categoryAvailableChildren = new CategoryAvailableChildren()
        categoryAvailableChildrenService.save(categoryAvailableChildren)

        then:
        categoryAvailableChildren.id != null
    }
}
