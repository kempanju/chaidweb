package chaid

import grails.gorm.services.Service

@Service(ChildUnderFiveImmunization)
interface ChildUnderFiveImmunizationService {

    ChildUnderFiveImmunization get(Serializable id)

    List<ChildUnderFiveImmunization> list(Map args)

    Long count()

    void delete(Serializable id)

    ChildUnderFiveImmunization save(ChildUnderFiveImmunization childUnderFiveImmunization)

}