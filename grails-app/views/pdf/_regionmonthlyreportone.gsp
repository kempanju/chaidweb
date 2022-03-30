<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
    <title>
    Country Report
    </title>
    <asset:stylesheet src="application.css"/>
    <asset:stylesheet src="bootstrap.css"/>
    <style type="text/css">
    p {
        margin: 5px auto;

    }

    hr {
        display: block;
        height: 1px;
        border: 0;
        border-top: 1px solid #000000;
        margin: 1em 0;
        padding: 0;
    }

    @media print {

        /* ... the rest of the rules ... */
        .table-bordered {
            border: 1px solid red;

        }
        @page {
            size: A4 portrait;
            padding: 0;
            margin: 0;
        }
        table {
            width: 100%;
            margin: 0;
            border-collapse: collapse;
            padding: 2px;
        }
        table tr td{
            padding: 3px;
        }
        table tr th{
            padding: 3px;
        }
        @page :left {
            margin-left: 1mm;
        }

        @page :right {
            margin-left: 1mm;
        }
    }





    </style>


</head>

<body style="width: 100%;padding: 0;margin: 0" >
<%
    def title  = regionInstance.name+ " Monthly Report";
    if (end_date && from_date) {
        title = title+" from "+from_date+" To "+end_date
    }
%>
<h2 style="text-align: center">${title} </h2>
<g:render template="/report/regionmonthlyreportnew"/>

</body>
</html>