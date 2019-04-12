package org.oecm8.postApp;

import java.io.IOException;
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.*;

import javax.faces.application.ProtectedViewException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.http.*;

public class FirstServlet1 extends HttpServlet{
	Protected void dopost(HttpServletRequest req,HttpServletResponse resp) throws ServletException,IOException
	{
			String eid=req.getParameter("i");
			int id+Integer.parseInt(eid);
			String name=req.getParameter("nm");
			String dept=req.getParameter("dp");
			String eperc=req.getParameter("pr");
			double perc=Double.parseDouble(eperc);
			PrintWriter out=resp.getWriter();
			out.println("<html><body bgcolor='yellow'>"
					+ "<h1>welcome"+name+" "+dept+"</h1>"
							+ "</body></html>");
			out.flush();
			out.close();
			Connection con=null;
			PreparedStatement pstml=null;
			String qry="insert into oecm8.student value(?,?,?,?)";
			try{
				Class.forName("com.mysql.jdbc.Driver");
				con=DriverManager.getConnection("jdbc:mysql://localhost:3306?user=root&password=dinga");
				pstml=con.prepareStatement(qry);
				pstml.setString(2, name);
				pstml.setString(3, dept);
				pstml.setDouble(4, perc);
				pstml.executeUpdate();
			}
			catch(ClassNotFoundException|SQLException e){
				e.printStackTrace();
			}
			finally
			
			{
				if(pstml!=null)
				{
					try{pstml.close();}
					catch(SQLException e){
						e.printStackTrace();
					}
				}
			}
		}
	}

