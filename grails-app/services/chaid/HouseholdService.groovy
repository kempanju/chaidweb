package chaid

import grails.gorm.services.Service

@Service(Household)
interface HouseholdService {

    Household get(Serializable id)

    List<Household> list(Map args)

    Long count()

    void delete(Serializable id)

    Household save(Household household)

}