package materialize.view

import grails.gorm.services.Service

@Service(ChaidMeetingType)
interface ChaidMeetingTypeService {

    ChaidMeetingType get(Serializable id)

    List<ChaidMeetingType> list(Map args)

    Long count()

    void delete(Serializable id)

    ChaidMeetingType save(ChaidMeetingType chaidMeetingType)

}