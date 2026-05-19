package healthcare.admin;
// handles login,logout & admin opreators.
import javax.servlet.ServletException; // Imports servlet classes (Handling HTTP requests/responses,Managing sessions)
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException; //  error handling 
import java.util.List;   //store data
import java.util.stream.Collectors;     // used for filtering (search)

@WebServlet({"/admin/*", "/login", "/logout"})
public class AdminControllerServlet extends HttpServlet {  //  Extends `HttpServlet` to makes it a web controller

    private FileHandler fileHandler;

    @Override
    public void init() throws ServletException {
        fileHandler = new FileHandler();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { // Handles GET requests  (view pages, fetch data)
        String path = request.getServletPath();   // Gets URL path (like /login, /logout)

        if ("/login".equals(path)) {
            HttpSession existing = request.getSession(false);
            if (existing != null && existing.getAttribute("currentUser") != null) {
                response.sendRedirect(request.getContextPath() + "/");        // if user alreadt logged in redirect homepage
                return;
            }
            request.getRequestDispatcher("/login.jsp").forward(request, response);   //  show login page
            return;
        } else if ("/logout".equals(path)) {  // If logout request
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate(); //Destroy session (log out user)
            }
            response.sendRedirect(request.getContextPath() + "/login");  // Redirect to login page
            return;
        }

        // Handle /admin/*
        String action = request.getPathInfo();
        if (action == null) action = "/list";

        try {
            switch (action) {
                case "/new":
                    request.getRequestDispatcher("/admin-register.jsp").forward(request, response); // Shows admin registration form
                    break;
                case "/delete":
                    fileHandler.deleteAdmin(request.getParameter("id")); // Deletes admin using ID 
                    response.sendRedirect(request.getContextPath() + "/admin/list"); //  Refresh list page
                    break;
                case "/search":
                    String keyword = request.getParameter("keyword");  // Get search keyword
                    List<Admin> listAdmin = fileHandler.getAllAdmins();   // Get all admins
                    if (keyword != null && !keyword.trim().isEmpty()) {  
                        listAdmin = listAdmin.stream()   // Filter admins by:name,email
                            .filter(a -> a.getName().toLowerCase().contains(keyword.toLowerCase()) || 
                                         a.getEmail().toLowerCase().contains(keyword.toLowerCase()))
                            .collect(Collectors.toList());
                    }
                    request.setAttribute("listAdmin", listAdmin); // Send filtered list to JSP
                    request.setAttribute("keyword", keyword);   
                    request.getRequestDispatcher("/admin-dashboard.jsp").forward(request, response);  // Show results
                    break;
                case "/list": // Show all admins
                default:
                    request.setAttribute("listAdmin", fileHandler.getAllAdmins());  // Get all admins
                    request.getRequestDispatcher("/admin-dashboard.jsp").forward(request, response);  // Display in dashboard
                    break;
            }
        } catch (Exception ex) {
            throw new ServletException(ex);  // Converts error into servlet exception
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {  //  Handles form submissions
        String path = request.getServletPath();  //  Get request path

        if ("/login".equals(path)) {
            String email    = request.getParameter("email")    != null ? request.getParameter("email").trim()    : ""; // Get email
            String password = request.getParameter("password") != null ? request.getParameter("password").trim() : ""; //Get password
            String role     = request.getParameter("role")     != null ? request.getParameter("role").trim()     : "PATIENT";  //Get role

            LoggedInUser user = fileHandler.login(email, password, role); //Check credentials

            if (user != null) {
                HttpSession session = request.getSession();  // Create session
                session.setAttribute("currentUser", user);  //Store user
                session.setAttribute("userRole", user.getRole()); // store role
                session.setAttribute("userName", user.getName());
                response.sendRedirect(request.getContextPath() + "/"); //Go to dashboard
            } else {
                request.setAttribute("error", "Incorrect email or password. Please try again.");
                request.setAttribute("emailTyped", email); 
                request.getRequestDispatcher("/login.jsp").forward(request, response); // Stay on login page
            }
            return;
        }

        // Handle /admin/*
        String action = request.getPathInfo();
        if (action == null) action = "/list";

        try {
            switch (action) {
                case "/insert":  // Insert admin
                    String id = "AD" + String.format("%03d", fileHandler.getAllAdmins().size() + 1);  //Generate ID
                    Admin newAdmin = new Admin(id, request.getParameter("name"), request.getParameter("email"), request.getParameter("password"));  // Create new admin
                    fileHandler.saveAdmin(newAdmin);  // save the file
                    response.sendRedirect(request.getContextPath() + "/admin/list"); //Show updated list
                    break;
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }
}
