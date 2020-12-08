package chaid

import grails.gorm.services.Service

@Service(ChadStatus)
interface ChadStatusService {

    ChadStatus get(Serializable id)

    List<ChadStatus> list(Map args)

    Long count()

    void delete(Serializable id)

    ChadStatus save(ChadStatus chadStatus)

}