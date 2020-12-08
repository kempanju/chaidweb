package chaid

import grails.gorm.services.Service

@Service(ActivityType)
interface ActivityTypeService {

    ActivityType get(Serializable id)

    List<ActivityType> list(Map args)

    Long count()

    void delete(Serializable id)

    ActivityType save(ActivityType activityType)

}