package chaid

import grails.gorm.services.Service

@Service(DangerSignAvailableChildren)
interface DangerSignAvailableChildrenService {

    DangerSignAvailableChildren get(Serializable id)

    List<DangerSignAvailableChildren> list(Map args)

    Long count()

    void delete(Serializable id)

    DangerSignAvailableChildren save(DangerSignAvailableChildren dangerSignAvailableChildren)

}