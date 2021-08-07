package materialize.view

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class ChaidVisitTypeServiceSpec extends Specification {

    ChaidVisitTypeService chaidVisitTypeService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new ChaidVisitType(...).save(flush: true, failOnError: true)
        //new ChaidVisitType(...).save(flush: true, failOnError: true)
        //ChaidVisitType chaidVisitType = new ChaidVisitType(...).save(flush: true, failOnError: true)
        //new ChaidVisitType(...).save(flush: true, failOnError: true)
        //new ChaidVisitType(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //chaidVisitType.id
    }

    void "test get"() {
        setupData()

        expect:
        chaidVisitTypeService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<ChaidVisitType> chaidVisitTypeList = chaidVisitTypeService.list(max: 2, offset: 2)

        then:
        chaidVisitTypeList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        chaidVisitTypeService.count() == 5
    }

    void "test delete"() {
        Long chaidVisitTypeId = setupData()

        expect:
        chaidVisitTypeService.count() == 5

        when:
        chaidVisitTypeService.delete(chaidVisitTypeId)
        sessionFactory.currentSession.flush()

        then:
        chaidVisitTypeService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        ChaidVisitType chaidVisitType = new ChaidVisitType()
        chaidVisitTypeService.save(chaidVisitType)

        then:
        chaidVisitType.id != null
    }
}
