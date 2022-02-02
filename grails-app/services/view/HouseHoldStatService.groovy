package view

import grails.gorm.services.Service

@Service(HouseHoldStat)
interface HouseHoldStatService {

    HouseHoldStat get(Serializable id)

    List<HouseHoldStat> list(Map args)

    Long count()

    void delete(Serializable id)

    HouseHoldStat save(HouseHoldStat houseHoldStat)

}