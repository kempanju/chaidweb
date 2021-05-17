

<div class="form-group">
        <label  class="control-label col-lg-3"><g:message code="name.en" default="Name"/> <span class="text-danger">*</span></label>
        <div class="col-lg-5">
            <input type="text" name="name" class="form-control" autocomplete="name" required="required" value="${subStreet?.name}">
        </div>
    </div>


<div class="form-group">
            <label class="control-label col-lg-3">Wilaya</label>

            <div class="col-lg-5">
                <g:select name="district_id" id="district_id" value="${subStreet?.district_id?.id}" onchange="getVillages(this)"
                          data-show-subtext="true" data-live-search="true"
                          from="${admin.District.findAllByD_deleted(false)}" optionKey="id" optionValue="name"
                          class="form-control" noSelection="['': 'District']"/>

            </div>
        </div>


     <div class="form-group" id="list-village">
     <g:if test="${params.id}">

     <label class="control-label col-lg-3">Village</label>

                 <div class="col-lg-5">
                     <g:select name="village_id" id="village_id"
                               from="${admin.Street.findAllByDistrict_id(subStreet?.district_id)}" optionKey="id" value="${subStreet.village_id.id}" optionValue="name"
                               class="form-control " noSelection="['': 'Village']"/>

                 </div>

     </g:if>

</div>

