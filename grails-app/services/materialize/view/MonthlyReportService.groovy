package materialize.view

import grails.gorm.services.Service

@Service(MonthlyReport)
interface MonthlyReportService {

    MonthlyReport get(Serializable id)

    List<MonthlyReport> list(Map args)

    Long count()

    void delete(Serializable id)

    MonthlyReport save(MonthlyReport monthlyReport)

}