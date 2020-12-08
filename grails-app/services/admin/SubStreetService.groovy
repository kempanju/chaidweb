package admin

import grails.gorm.services.Service

@Service(SubStreet)
interface SubStreetService {

    SubStreet get(Serializable id)

    List<SubStreet> list(Map args)

    Long count()

    void delete(Serializable id)

    SubStreet save(SubStreet subStreet)

}