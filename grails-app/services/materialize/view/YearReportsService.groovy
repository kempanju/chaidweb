package materialize.view

import grails.gorm.services.Service

@Service(YearReports)
interface YearReportsService {

    YearReports get(Serializable id)

    List<YearReports> list(Map args)

    Long count()

    void delete(Serializable id)

    YearReports save(YearReports yearReports)

}