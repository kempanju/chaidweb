<div style=" overflow-x: auto;">
   <table class="table  table-bordered">

    <tr>
            <td colspan="18" class="text-bold text-center">PROVISION OF HEALTH EDUCATION AND FOLLOW UP AT HOUSEHOLD LEVEL</td>
         </tr>


        <g:each in="${admin.DictionaryItem.findAllByDictionary_id(admin.Dictionary.findByCode("CHAD6"))}" status="i" var="educationListInstance">

        <tr>
        <td>${educationListInstance.name}</td>

        <td></td>
        </tr>
        </g:each>


   </table>
</div>