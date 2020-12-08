 <label class="control-label col-lg-3">Ward</label>

            <div class="col-lg-5">
                <g:select name="ward_id" id="ward_id"

                          from="${wardListInstance}" optionKey="id" optionValue="name"
                          class="form-control " noSelection="['': 'Ward']"/>

            </div>