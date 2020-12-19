package chaid

import grails.gorm.services.Service

@Service(CategoryAvailableChildren)
interface CategoryAvailableChildrenService {

    CategoryAvailableChildren get(Serializable id)

    List<CategoryAvailableChildren> list(Map args)

    Long count()

    void delete(Serializable id)

    CategoryAvailableChildren save(CategoryAvailableChildren categoryAvailableChildren)

}