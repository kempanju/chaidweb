package materialize.view

import grails.gorm.services.Service

@Service(DangerSign)
interface DangerSignService {

    DangerSign get(Serializable id)

    List<DangerSign> list(Map args)

    Long count()

    void delete(Serializable id)

    DangerSign save(DangerSign dangerSign)

}