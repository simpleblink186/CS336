<%@ include file = "header.jsp" %>
<%@ include file = "functions.jsp" %>

<title>Dashboard</title>
<style>
button{width:250px;
	   text-align:center;
}
</style>
</head>
<body>
	<%
		try {
			//store userName
			String uname=request.getParameter("userID");
			
			Connection con = dbConnect();

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String str = "SELECT * FROM users WHERE username='"+ uname + "' AND password='" + request.getParameter("password")+"';";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			if(!result.next()){
				out.println("<form method='post'><input type='hidden' id='errormsg' name = 'error' value='error'></input></form>");
				response.sendRedirect("index.jsp?error=error");
				return;
			}
			else{
			
				//logic to build dashboard
				//TODO:this needs to be primary key, not name
				session.setAttribute("username", result.getString(1)); 
				session.setAttribute("fname", result.getString(5));
				session.setAttribute("lname",result.getString(6));
				session.setAttribute("address", result.getString(7));
				session.setAttribute("city", result.getString(8));
				session.setAttribute("state", result.getString(9));
				session.setAttribute("zip", result.getString(10));
				session.setAttribute("type", result.getString(18));
				if(session.getAttribute("type").equals("customer")){
					session.setAttribute("account_no", result.getString(3));
					session.setAttribute("email", result.getString(11));
					session.setAttribute("acctDate", result.getString(13));
					session.setAttribute("ccnum", result.getString(14));
					session.setAttribute("seat", result.getString(15));
					session.setAttribute("meal", result.getString(16));
				}
				else{
					session.setAttribute("ssn", result.getString(4));
					session.setAttribute("city", result.getString(12));
					session.setAttribute("startdate", result.getString(17));
				}
				
				out.println("<h1>Welcome, " + session.getAttribute("fname") +"!</h1>");
				
				//buttons for everyone
				out.println("<form method=get action='temp.jsp'>");
				if(session.getAttribute("type").equals("customer") || session.getAttribute("type").equals("employee")){
					out.println("<button name='makeRes' value='makeRes'>Make Reservation</button> <br> <br>");
				}
				out.println("<button name='viewRes' value='viewRes'>View Reservation</button> <br> <br>");
				if(session.getAttribute("type").equals("customer")){
					out.println("<button name='viewPopular' value='viewPopular'>View Popular Flights</button> <br> <br>");
				}
				out.println("<button name='viewProfile' value='viewProfile'>View Profile</button> <br> <br>");
				out.println("<button name='logout' value='logout'>Log Out</button><br><br>");
				out.println("<button name='editProfile' value='editProfile' style='Background-color:beige'>Edit Profile</button> <br> <br>");
				
				if(session.getAttribute("type").equals("employee")){
					out.println("<button name='mailList' value='mailList' style='Background-color:beige'>Create Mail List</button> <br> <br>");
					//View/Edit customer information
					//Suggest flights
				}
				
				//buttons for employees and managers
				if(session.getAttribute("type").equals("employee") || result.getString(18).equals("manager")) {		
					//View employee information
				}
				
				//buttons for managers
				if(session.getAttribute("type").equals("manager")) {
					out.println("<button name='report' value='report' style='Background-color:blue'>Sales Report</button> <br> <br>");
					out.println("<button name='viewFlights' value='viewFlights' style='Background-color:blue'>View Flights </button> <br> <br>");
					out.println("<button name='addUser' value='addUser' style='Background-color:blue'>Add User </button> <br> <br>");
					//View/Edit Employee Information
					out.println("<button name='revenue' value='revenue' style='Background-color:blue'>View Revenue </button> <br> <br>");
				}
				out.println("</form>");
				
				
	
			
				
				
				//close the connection.
				con.close();
			}
		} catch (Exception e) {
			out.println(e.getMessage());
			out.println("Uh oh");
		}
	%>

	</body>
</html>