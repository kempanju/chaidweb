package admin

import grails.gorm.services.Service

@Service(SystemLogs)
interface SystemLogsService {

    SystemLogs get(Serializable id)

    List<SystemLogs> list(Map args)

    Long count()

    void delete(Serializable id)

    SystemLogs save(SystemLogs systemLogs)

}