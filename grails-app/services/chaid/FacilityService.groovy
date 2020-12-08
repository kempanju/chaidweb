package chaid

import grails.gorm.services.Service

@Service(Facility)
interface FacilityService {

    Facility get(Serializable id)

    List<Facility> list(Map args)

    Long count()

    void delete(Serializable id)

    Facility save(Facility facility)

}