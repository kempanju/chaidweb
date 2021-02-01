package chaid

import grails.gorm.services.Service

@Service(HealthEducation)
interface HealthEducationService {

    HealthEducation get(Serializable id)

    List<HealthEducation> list(Map args)

    Long count()

    void delete(Serializable id)

    HealthEducation save(HealthEducation healthEducation)

}