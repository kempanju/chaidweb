
            <div class="col-lg-10">
                <g:select name="village_id" id="village_id"

                          from="${streetListInstance}" optionKey="id" optionValue="name" onchange="getReports(this)"
                          class="form-control " noSelection="['': 'Select Village']"/>

            </div>