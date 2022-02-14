<%
    if Session("SUserEmail") = "" OR Session("SUserPass") = "" then 
        Session("STimeoutError") = "Your Session has been Timeout"
        response.redirect("Login.asp")
    end if
%>
<!--#include file=ValidateLogin.asp-->