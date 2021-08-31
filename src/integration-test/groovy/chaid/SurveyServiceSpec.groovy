package chaid

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class SurveyServiceSpec extends Specification {

    SurveyService surveyService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Survey(...).save(flush: true, failOnError: true)
        //new Survey(...).save(flush: true, failOnError: true)
        //Survey survey = new Survey(...).save(flush: true, failOnError: true)
        //new Survey(...).save(flush: true, failOnError: true)
        //new Survey(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //survey.id
    }

    void "test get"() {
        setupData()

        expect:
        surveyService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Survey> surveyList = surveyService.list(max: 2, offset: 2)

        then:
        surveyList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        surveyService.count() == 5
    }

    void "test delete"() {
        Long surveyId = setupData()

        expect:
        surveyService.count() == 5

        when:
        surveyService.delete(surveyId)
        sessionFactory.currentSession.flush()

        then:
        surveyService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Survey survey = new Survey()
        surveyService.save(survey)

        then:
        survey.id != null
    }
}
