package materialize.view

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class ViewHealthEducationServiceSpec extends Specification {

    ViewHealthEducationService viewHealthEducationService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new ViewHealthEducation(...).save(flush: true, failOnError: true)
        //new ViewHealthEducation(...).save(flush: true, failOnError: true)
        //ViewHealthEducation viewHealthEducation = new ViewHealthEducation(...).save(flush: true, failOnError: true)
        //new ViewHealthEducation(...).save(flush: true, failOnError: true)
        //new ViewHealthEducation(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //viewHealthEducation.id
    }

    void "test get"() {
        setupData()

        expect:
        viewHealthEducationService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<ViewHealthEducation> viewHealthEducationList = viewHealthEducationService.list(max: 2, offset: 2)

        then:
        viewHealthEducationList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        viewHealthEducationService.count() == 5
    }

    void "test delete"() {
        Long viewHealthEducationId = setupData()

        expect:
        viewHealthEducationService.count() == 5

        when:
        viewHealthEducationService.delete(viewHealthEducationId)
        sessionFactory.currentSession.flush()

        then:
        viewHealthEducationService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        ViewHealthEducation viewHealthEducation = new ViewHealthEducation()
        viewHealthEducationService.save(viewHealthEducation)

        then:
        viewHealthEducation.id != null
    }
}
