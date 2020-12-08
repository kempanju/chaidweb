<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'subStreet.label', default: 'SubStreet')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
     <div class="register_dv expert">
            <div class="center  panel-body">


 <div class="btn-group btn-breadcrumb">
            <g:link controller="home" action="dashboard" class="btn btn-default"><i
                    class="glyphicon glyphicon-home"></i></g:link>
            <g:link controller="home" action="dashboard" class="btn btn-default">Dashboard</g:link>

            <a href="#"
               class="btn btn-primary">${message(code: 'application.list', default: 'Reports By Village')} </a>
        </div>
 </div>
        <div class="col-lg-5">

        <div class="form-group">
                       <label class="control-label col-lg-7">Wilaya</label>

                       <div class="col-lg-5">
                           <g:select name="district_id" id="district_id" value="" onchange="getVillageReports(this)"
                                     data-show-subtext="true" data-live-search="true"
                                     from="${admin.District.findAllByD_deleted(false)}" optionKey="id" optionValue="name"
                                     class="form-control selectpicker" noSelection="['': 'District']"/>

                       </div>
                   </div>

        </div>
<div class="col-lg-12" style="max-height:500px;overflow:auto" id="village-report">

</div>

      </div>
      </body>
  </html>