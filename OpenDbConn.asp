<%
    'OpenDbConn Procedure Start
    Dim Conn
    Dim CS
        Sub OpenDbConn()
            Set Conn = Server.CreateObject("ADODB.Connection")
            CS = "Driver={SQL Server};Server=NABEELS-WORK;Database=TrainingManagementSystem;User Id=TMS;Password=Nabeel30;"
            Conn.Open CS
        End Sub
    'End
%>