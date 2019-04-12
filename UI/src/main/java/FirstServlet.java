import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FirstServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException,IOException{
		String eid=req.getParameter("i");
		int id=Integer.parseInt(eid);
		String name =req.getParameter("name");
		String dept=req.getParameter("dep");
		String eperc=req.getParameter("per");
		int per=Integer.parseInt(eperc);
		PrintWriter out=resp.getWriter();
		out.println("<html><body bgcolor='yellow'>"
				+ "<h1>welcome "+name+" "+dept+"</h1>"
				+"</body></html");
		out.flush();
		out.close();
		Connection con=null;
		PreparedStatement pstmt=null;
		String qry="insert into db_app.satsangAtt values(?,?,?,?)";
		try{
			Class.forName("Com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306?user=root&password=dinga");
			pstmt=con.prepareStatement(qry);
			pstmt.setString(2, name);
			pstmt.setString(3, dept);
			pstmt.setInt(4, per);
			pstmt.executeUpdate();
		}
		catch(ClassNotFoundException|SQLException e){
			e.printStackTrace();
		}
		finally {
			if(pstmt!=null){
				try{
					pstmt.close();
				}catch(SQLException e){
					e.printStackTrace();
				}
			}
		}
		
		
	}

}
