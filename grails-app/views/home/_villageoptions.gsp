 <label class="control-label col-lg-3">Village</label>

            <div class="col-lg-5">
                <g:select name="village_id" id="village_id"

                          from="${streetListInstance}" optionKey="id" optionValue="name"
                          class="form-control " noSelection="['': 'Village']"/>

            </div>