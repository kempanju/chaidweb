package chaid

import grails.gorm.services.Service

@Service(Survey)
interface SurveyService {

    Survey get(Serializable id)

    List<Survey> list(Map args)

    Long count()

    void delete(Serializable id)

    Survey save(Survey survey)

}