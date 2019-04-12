import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class Main extends HttpServlet {

    private String message;

    public void init() throws ServletException {
        // Do required initialization
        message = "Hello World !!!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        if (!verifyBrowser(request)) {
            out.println("Only Google Chrome Supported !!");
            return;
        }

        out.println(request.getRequestURL());
        out.println(request.getRequestURI());

//        if (request.getRequestURI().contains("AddSG")) {
            System.out.println("Redirecting");
            response.sendRedirect("/Preacher.jsp");
//            request.getRequestDispatcher("SgReg.jsp").forward(request, response);

//        }
    }

    boolean verifyBrowser(HttpServletRequest request) {
        String ua = request.getHeader("User-Agent");
        System.out.println(ua);
        if (ua.indexOf("Chrome") == -1) {
            return false;
        }
        return true;
    }

    public void destroy() {
        // do nothing.
    }
}
