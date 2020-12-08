package com.chaid.security

import grails.gorm.services.Service

@Service(MkpUser)
interface MkpUserService {

    MkpUser get(Serializable id)

    List<MkpUser> list(Map args)

    Long count()

    void delete(Serializable id)

    MkpUser save(MkpUser mkpUser)

}