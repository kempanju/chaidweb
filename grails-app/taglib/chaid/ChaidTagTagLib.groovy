package chaid

class ChaidTagTagLib {
    static defaultEncodeAs = [taglib:'html']
    //static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]
    def formatAmountString = { attrs, body ->
        try {

            def amount = attrs.name
            // println(amount)
            if(amount) {
                def formatedstring = String.format("%,8d%n",amount)

                //  def finalNumber = formatedstring.substring(0, 5) + " " + formatedstring.substring(7, formatedstring.length())

                out << formatedstring
            }else {
                out << "0"
            }
        }catch (Exception e){
            //e.printStackTrace()
            out << "0"
        }


    }
}
