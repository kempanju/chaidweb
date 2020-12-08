package chaid

import grails.gorm.services.Service

@Service(EducationType)
interface EducationTypeService {

    EducationType get(Serializable id)

    List<EducationType> list(Map args)

    Long count()

    void delete(Serializable id)

    EducationType save(EducationType educationType)

}