<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>
<% 
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	String x="a";
	String y= "b";
	if(name.equals(x) && password.equals(y))
		{
		session.setAttribute("name",name);				
		response.sendRedirect("index.jsp");				
		}						   
		else{
		response.sendRedirect("error.jsp");			
}
%>
</body>
</html>