package materialize.view

import grails.gorm.services.Service

@Service(AvailableMember)
interface AvailableMemberService {

    AvailableMember get(Serializable id)

    List<AvailableMember> list(Map args)

    Long count()

    void delete(Serializable id)

    AvailableMember save(AvailableMember availableMember)

}