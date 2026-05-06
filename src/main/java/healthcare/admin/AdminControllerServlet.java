package healthcare.admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet({"/admin/*", "/login", "/logout"})
public class AdminControllerServlet extends HttpServlet {

    private FileHandler fileHandler;

    @Override
    public void init() throws ServletException {
        fileHandler = new FileHandler();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/login".equals(path)) {
            HttpSession existing = request.getSession(false);
            if (existing != null && existing.getAttribute("currentUser") != null) {
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        } else if ("/logout".equals(path)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Handle /admin/*
        String action = request.getPathInfo();
        if (action == null) action = "/list";

        try {
            switch (action) {
                case "/new":
                    request.getRequestDispatcher("/admin-register.jsp").forward(request, response);
                    break;
                case "/delete":
                    fileHandler.deleteAdmin(request.getParameter("id"));
                    response.sendRedirect(request.getContextPath() + "/admin/list");
                    break;
                case "/search":
                    String keyword = request.getParameter("keyword");
                    List<Admin> listAdmin = fileHandler.getAllAdmins();
                    if (keyword != null && !keyword.trim().isEmpty()) {
                        listAdmin = listAdmin.stream()
                            .filter(a -> a.getName().toLowerCase().contains(keyword.toLowerCase()) || 
                                         a.getEmail().toLowerCase().contains(keyword.toLowerCase()))
                            .collect(Collectors.toList());
                    }
                    request.setAttribute("listAdmin", listAdmin);
                    request.setAttribute("keyword", keyword);
                    request.getRequestDispatcher("/admin-dashboard.jsp").forward(request, response);
                    break;
                case "/list":
                default:
                    request.setAttribute("listAdmin", fileHandler.getAllAdmins());
                    request.getRequestDispatcher("/admin-dashboard.jsp").forward(request, response);
                    break;
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/login".equals(path)) {
            String email    = request.getParameter("email")    != null ? request.getParameter("email").trim()    : "";
            String password = request.getParameter("password") != null ? request.getParameter("password").trim() : "";
            String role     = request.getParameter("role")     != null ? request.getParameter("role").trim()     : "PATIENT";

            LoggedInUser user = fileHandler.login(email, password, role);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("currentUser", user);
                session.setAttribute("userRole", user.getRole());
                session.setAttribute("userName", user.getName());
                response.sendRedirect(request.getContextPath() + "/");
            } else {
                request.setAttribute("error", "Incorrect email or password. Please try again.");
                request.setAttribute("emailTyped", email);
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
            return;
        }

        // Handle /admin/*
        String action = request.getPathInfo();
        if (action == null) action = "/list";

        try {
            switch (action) {
                case "/insert":
                    String id = "AD" + String.format("%03d", fileHandler.getAllAdmins().size() + 1);
                    Admin newAdmin = new Admin(id, request.getParameter("name"), request.getParameter("email"), request.getParameter("password"));
                    fileHandler.saveAdmin(newAdmin);
                    response.sendRedirect(request.getContextPath() + "/admin/list");
                    break;
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }
}
