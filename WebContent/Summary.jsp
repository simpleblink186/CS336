<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>Revenue Summary</title>
<body>
<h1>Revenue Summary</h1>
<style>
table, th, td {
	border: 1px solid black;
}
td {
	width:10%;
}</style>
<% try{
	//declare variables
	Connection con;
	Statement stmt;
	String type;
	String str;
	ResultSet result;
	
	con = dbConnect();
	
	stmt = con.createStatement();
		
	//build sql query
	
			int showby = Integer.parseInt(request.getParameter("showby").toString());
			
			 switch (showby){
			 	case 1:
			 		//flight sort
			 		str="SELECT FLNumber, SUM(ResTotalFare)+SUM(ResBookingFee) AS profit FROM airline.reservations r, airline.has h WHERE r.ResNumber=h.ResNumber GROUP BY FLNumber ORDER BY profit desc;";

			 		result = stmt.executeQuery(str);

					out.println("<table style='width:1000'>");
			 		out.println("<tr>");
					out.println("<td>");
						out.println("Flight Number");
					out.println("</td>");
					
					out.println("<td>");
						out.println("Revenue");  
					out.println("</td>");
					
					out.println("</tr>");
					while(result.next()) {
						
						
						out.println("<td>");
						out.print(result.getString(1));
						out.println("</td>");
						
						out.println("<td>");
						out.print(result.getString(2));
						out.println("</td>");
						
						
						out.println("</tr>");
					}
					 out.println("</table>");
			 			break;
			 	case 2:
			 		str="SELECT account_no, SUM(ResBookingFee)+SUM(ResTotalFare) as profit FROM airline.makes m, airline.reservations r WHERE m.ResNumber=r.ResNumber GROUP BY account_no ORDER BY profit DESC;";

			 		result = stmt.executeQuery(str);

					out.println("<table style='width:1000'>");
			 		out.println("<tr>");
					out.println("<td>");
						out.println("Account Number");
					out.println("</td>");
					
					out.println("<td>");
						out.println("Revenue");  
					out.println("</td>");
					
					out.println("</tr>");
					while(result.next()) {
						
						
						out.println("<td>");
						out.print(result.getString(1));
						out.println("</td>");
						
						out.println("<td>");
						out.print(result.getString(2));
						out.println("</td>");
						
						
						out.println("</tr>");
					}
					 out.println("</table>");
			 			break;
			 	case 3:
			 		//airport
			 		str="SELECT FIDeparts, SUM(ResTotalFare)+SUM(ResBookingFee) AS profit"
			 			+ " FROM airline.reservations r, airline.has h, airline.flightinfo f" 
			 			+  " WHERE r.ResNumber=h.ResNumber AND h.FLNumber=f.FInumber"
			 			+	" GROUP BY FIDeparts ORDER BY profit DESC;";


			 		result = stmt.executeQuery(str);

					out.println("<table style='width:1000'>");
			 		out.println("<tr>");
					out.println("<td>");
						out.println("Airport");
					out.println("</td>");
					
					out.println("<td>");
						out.println("Revenue");  
					out.println("</td>");
					
					out.println("</tr>");
					while(result.next()) {
						
						
						out.println("<td>");
						out.print(result.getString(1));
						out.println("</td>");
						
						out.println("<td>");
						out.print(result.getString(2));
						out.println("</td>");
						
						
						out.println("</tr>");
					}
					 out.println("</table>");
			 		
			 		
			 			break;
				 default:
					 	break;
			 }
	
			
			
			//manager page
			
			//Top labels

		
		
} catch (SQLException e) {
	out.println(e.getMessage());
	out.println("Uh oh");
}
%>
</body>
</html>