package materialize.view

import grails.gorm.services.Service

@Service(ViewHealthEducation)
interface ViewHealthEducationService {

    ViewHealthEducation get(Serializable id)

    List<ViewHealthEducation> list(Map args)

    Long count()

    void delete(Serializable id)

    ViewHealthEducation save(ViewHealthEducation viewHealthEducation)

}