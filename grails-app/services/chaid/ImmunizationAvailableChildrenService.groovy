package chaid

import grails.gorm.services.Service

@Service(ImmunizationAvailableChildren)
interface ImmunizationAvailableChildrenService {

    ImmunizationAvailableChildren get(Serializable id)

    List<ImmunizationAvailableChildren> list(Map args)

    Long count()

    void delete(Serializable id)

    ImmunizationAvailableChildren save(ImmunizationAvailableChildren immunizationAvailableChildren)

}