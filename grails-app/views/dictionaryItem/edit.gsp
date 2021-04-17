<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'dictionaryItem.label', default: 'DictionaryItem')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#edit-dictionaryItem" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="edit-dictionaryItem" class="content scaffold-edit" role="main">
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.dictionaryItem}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.dictionaryItem}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <g:form resource="${this.dictionaryItem}" method="PUT" class="form-horizontal">
                <g:hiddenField name="version" value="${this.dictionaryItem?.version}" />

                  <fieldset class="form">
                                                    <g:render template="form" bean="dictionaryItem"/>
                                                    <div class="text-right col-lg-8">
                                                        <button type="submit" class="btn btn-primary"><g:message code="save" default="Save"/> <i
                                                                class="icon-arrow-right14 position-right"></i>
                                                        </button>

                                                    </div>
                                                </fieldset>
            </g:form>
        </div>
    </body>
</html>
