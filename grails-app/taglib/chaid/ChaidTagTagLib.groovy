package chaid

import java.text.DateFormat
import java.text.SimpleDateFormat

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

    def formatDateCustomGroovy = { attrs, body ->

        def datetoday=attrs.name
        SimpleDateFormat sdf = new SimpleDateFormat(
                "yyyy-MM-dd HH:mm:ss", Locale.getDefault());
        SimpleDateFormat normaldate = new SimpleDateFormat("MMM", Locale.getDefault());
        Date convertedCurrentDate;
        String outputdate = null;
        try {
            convertedCurrentDate = sdf.parse(datetoday);
            Calendar cal = Calendar.getInstance();
            cal.setTime(convertedCurrentDate);

            // if (days > 5) {
            outputdate = "" + normaldate.format(convertedCurrentDate);

        } catch (java.text.ParseException e) {

             e.printStackTrace();
        }

        out << outputdate
    }
    def formatDateCustomDayGroovy = { attrs, body ->

        def datetoday=attrs.name
        SimpleDateFormat sdf = new SimpleDateFormat(
                "yyyy-MM-dd HH:mm:ss", Locale.getDefault());
        SimpleDateFormat normaldate = new SimpleDateFormat("dd EEEE", Locale.getDefault());
        Date convertedCurrentDate;
        String outputdate = null;
        try {
            convertedCurrentDate = sdf.parse(datetoday);
            Calendar cal = Calendar.getInstance();
            cal.setTime(convertedCurrentDate);

            // if (days > 5) {
            outputdate = "" + normaldate.format(convertedCurrentDate);

        } catch (java.text.ParseException e) {

            e.printStackTrace();
        }

        out << outputdate
    }



}
