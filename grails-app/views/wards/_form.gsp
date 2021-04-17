 <div class="form-group">
            <label class="control-label col-lg-3">Name</label>

            <div class="col-lg-5">

                <input type="text" name="name" placeholder="Name" class="form-control" required="required"
                       value="${wards?.name}">

            </div>
</div>

 <div class="form-group">
            <label class="control-label col-lg-3">District</label>

            <div class="col-lg-5">
                <g:select name="district_id" id="district_id" value="${wards?.district_id?.id}"
                          data-show-subtext="true" data-live-search="true"
                          from="${admin.District.list()}" optionKey="id" optionValue="name"
                          class="form-control " noSelection="['': 'District']"/>

            </div>
        </div>