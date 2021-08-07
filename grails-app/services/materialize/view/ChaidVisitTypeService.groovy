package materialize.view

import grails.gorm.services.Service

@Service(ChaidVisitType)
interface ChaidVisitTypeService {

    ChaidVisitType get(Serializable id)

    List<ChaidVisitType> list(Map args)

    Long count()

    void delete(Serializable id)

    ChaidVisitType save(ChaidVisitType chaidVisitType)

}