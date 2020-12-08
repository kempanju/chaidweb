package chaid

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class EducationTypeServiceSpec extends Specification {

    EducationTypeService educationTypeService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new EducationType(...).save(flush: true, failOnError: true)
        //new EducationType(...).save(flush: true, failOnError: true)
        //EducationType educationType = new EducationType(...).save(flush: true, failOnError: true)
        //new EducationType(...).save(flush: true, failOnError: true)
        //new EducationType(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //educationType.id
    }

    void "test get"() {
        setupData()

        expect:
        educationTypeService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<EducationType> educationTypeList = educationTypeService.list(max: 2, offset: 2)

        then:
        educationTypeList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        educationTypeService.count() == 5
    }

    void "test delete"() {
        Long educationTypeId = setupData()

        expect:
        educationTypeService.count() == 5

        when:
        educationTypeService.delete(educationTypeId)
        sessionFactory.currentSession.flush()

        then:
        educationTypeService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        EducationType educationType = new EducationType()
        educationTypeService.save(educationType)

        then:
        educationType.id != null
    }
}
