package com.chaid.security

import grails.testing.gorm.DomainUnitTest
import grails.testing.web.controllers.ControllerUnitTest
import grails.validation.ValidationException
import spock.lang.*

class MkpUserControllerSpec extends Specification implements ControllerUnitTest<MkpUserController>, DomainUnitTest<MkpUser> {

    def populateValidParams(params) {
        assert params != null

        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
        assert false, "TODO: Provide a populateValidParams() implementation for this generated test suite"
    }

    void "Test the index action returns the correct model"() {
        given:
        controller.mkpUserService = Mock(MkpUserService) {
            1 * list(_) >> []
            1 * count() >> 0
        }

        when:"The index action is executed"
        controller.index()

        then:"The model is correct"
        !model.mkpUserList
        model.mkpUserCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
        controller.create()

        then:"The model is correctly created"
        model.mkpUser!= null
    }

    void "Test the save action with a null instance"() {
        when:"Save is called for a domain instance that doesn't exist"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'POST'
        controller.save(null)

        then:"A 404 error is returned"
        response.redirectedUrl == '/mkpUser/index'
        flash.message != null
    }

    void "Test the save action correctly persists"() {
        given:
        controller.mkpUserService = Mock(MkpUserService) {
            1 * save(_ as MkpUser)
        }

        when:"The save action is executed with a valid instance"
        response.reset()
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'POST'
        populateValidParams(params)
        def mkpUser = new MkpUser(params)
        mkpUser.id = 1

        controller.save(mkpUser)

        then:"A redirect is issued to the show action"
        response.redirectedUrl == '/mkpUser/show/1'
        controller.flash.message != null
    }

    void "Test the save action with an invalid instance"() {
        given:
        controller.mkpUserService = Mock(MkpUserService) {
            1 * save(_ as MkpUser) >> { MkpUser mkpUser ->
                throw new ValidationException("Invalid instance", mkpUser.errors)
            }
        }

        when:"The save action is executed with an invalid instance"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'POST'
        def mkpUser = new MkpUser()
        controller.save(mkpUser)

        then:"The create view is rendered again with the correct model"
        model.mkpUser != null
        view == 'create'
    }

    void "Test the show action with a null id"() {
        given:
        controller.mkpUserService = Mock(MkpUserService) {
            1 * get(null) >> null
        }

        when:"The show action is executed with a null domain"
        controller.show(null)

        then:"A 404 error is returned"
        response.status == 404
    }

    void "Test the show action with a valid id"() {
        given:
        controller.mkpUserService = Mock(MkpUserService) {
            1 * get(2) >> new MkpUser()
        }

        when:"A domain instance is passed to the show action"
        controller.show(2)

        then:"A model is populated containing the domain instance"
        model.mkpUser instanceof MkpUser
    }

    void "Test the edit action with a null id"() {
        given:
        controller.mkpUserService = Mock(MkpUserService) {
            1 * get(null) >> null
        }

        when:"The show action is executed with a null domain"
        controller.edit(null)

        then:"A 404 error is returned"
        response.status == 404
    }

    void "Test the edit action with a valid id"() {
        given:
        controller.mkpUserService = Mock(MkpUserService) {
            1 * get(2) >> new MkpUser()
        }

        when:"A domain instance is passed to the show action"
        controller.edit(2)

        then:"A model is populated containing the domain instance"
        model.mkpUser instanceof MkpUser
    }


    void "Test the update action with a null instance"() {
        when:"Save is called for a domain instance that doesn't exist"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'PUT'
        controller.update(null)

        then:"A 404 error is returned"
        response.redirectedUrl == '/mkpUser/index'
        flash.message != null
    }

    void "Test the update action correctly persists"() {
        given:
        controller.mkpUserService = Mock(MkpUserService) {
            1 * save(_ as MkpUser)
        }

        when:"The save action is executed with a valid instance"
        response.reset()
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'PUT'
        populateValidParams(params)
        def mkpUser = new MkpUser(params)
        mkpUser.id = 1

        controller.update(mkpUser)

        then:"A redirect is issued to the show action"
        response.redirectedUrl == '/mkpUser/show/1'
        controller.flash.message != null
    }

    void "Test the update action with an invalid instance"() {
        given:
        controller.mkpUserService = Mock(MkpUserService) {
            1 * save(_ as MkpUser) >> { MkpUser mkpUser ->
                throw new ValidationException("Invalid instance", mkpUser.errors)
            }
        }

        when:"The save action is executed with an invalid instance"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'PUT'
        controller.update(new MkpUser())

        then:"The edit view is rendered again with the correct model"
        model.mkpUser != null
        view == 'edit'
    }

    void "Test the delete action with a null instance"() {
        when:"The delete action is called for a null instance"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'DELETE'
        controller.delete(null)

        then:"A 404 is returned"
        response.redirectedUrl == '/mkpUser/index'
        flash.message != null
    }

    void "Test the delete action with an instance"() {
        given:
        controller.mkpUserService = Mock(MkpUserService) {
            1 * delete(2)
        }

        when:"The domain instance is passed to the delete action"
        request.contentType = FORM_CONTENT_TYPE
        request.method = 'DELETE'
        controller.delete(2)

        then:"The user is redirected to index"
        response.redirectedUrl == '/mkpUser/index'
        flash.message != null
    }
}






