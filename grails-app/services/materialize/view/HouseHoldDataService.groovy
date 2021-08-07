package materialize.view

import grails.gorm.services.Service

@Service(HouseHoldData)
interface HouseHoldDataService {

    HouseHoldData get(Serializable id)

    List<HouseHoldData> list(Map args)

    Long count()

    void delete(Serializable id)

    HouseHoldData save(HouseHoldData houseHoldData)

}