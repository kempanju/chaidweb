 <div class="form-group">
            <label class="control-label col-lg-3">Name</label>

            <div class="col-lg-5">

                <input type="text" name="name" placeholder="Name" class="form-control" required="required"
                       value="${district?.name}">

            </div>
</div>

 <div class="form-group">
            <label class="control-label col-lg-3">Region</label>

            <div class="col-lg-5">
                <g:select name="region_id" id="region_id" value="${district?.region_id?.id}"
                          data-show-subtext="true" data-live-search="true"
                          from="${admin.Region.list()}" optionKey="id" optionValue="name"
                          class="form-control selectpicker" noSelection="['': 'Region']"/>

            </div>
        </div>