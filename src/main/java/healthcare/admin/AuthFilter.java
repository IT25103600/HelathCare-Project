package healthcare.admin;

import healthcare.admin.LoggedInUser;  // Imports  LoggedInUser class (used to check user role).

import javax.servlet.*; // Needed for creating a Filter in Java web apps.
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest; //Used to handle HTTP requests, responses, and sessions.
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;  // Required for handling input/output errors.
// Intercepts EVERY request and checks:
//   - Is the user logged in?  → Let them through
//   - Are they on the login page? → Let them through
//   - Otherwise? → Redirect to /login
@WebFilter("/*")  // This filter runs on ALL URLs in my application.
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException { } // Runs once when the filter starts.Empty here (no setup needed).

    @Override
    public void destroy() { } // Runs when filter is destroyed.Used for cleanup (not used here).

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) // This runs for every request
            throws IOException, ServletException {

        HttpServletRequest  req = (HttpServletRequest)  request; // Type casting(Convert generic request/response into HTTP-specific versions)
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getRequestURI().substring(req.getContextPath().length()); //Get requested path

        // Always allow: static files, login page, logout page, and patient self-registration
        boolean isPublic = path.startsWith("/css/") // This allows access to:CSS, JS, Images,Login page,Logout page,registration page
                        || path.startsWith("/js/")
                        || path.startsWith("/images/")
                        || path.equals("/login")
                        || path.equals("/logout")
                        || path.equals("/register")
                        || path.endsWith("login.jsp")
                        || path.endsWith("patient-self-register.jsp");

        if (isPublic) {
            chain.doFilter(request, response); // Let request continue.Skip security checks
            return;
        }

        // Check session for a logged-in user
        HttpSession session = req.getSession(false); //false → don’t create new session,Only check existing session
        LoggedInUser user   = (session != null)  //Get logged-in user from session
                ? (LoggedInUser) session.getAttribute("currentUser")
                : null;

        if (user != null) {
            // --- Role-Based Access Control ---
            // Patients cannot access admin, billing, or doctor pages
            if (user.isPatient()) {
                boolean forbidden = path.startsWith("/admin") // Patient restrictions (patient cannot access admin billing,doctor)
                                 || path.startsWith("/billing")
                                 || path.startsWith("/doctor");
                if (forbidden) {
                    res.sendRedirect(req.getContextPath() + "/?error=AccessDenied");
                    return;
                }
            }

            // Doctors cannot access admin, billing, or patient pages
            if (user.isDoctor()) {
                boolean forbidden = path.startsWith("/admin")
                                 || path.startsWith("/billing")
                                 || path.startsWith("/patient");
                if (forbidden) {
                    res.sendRedirect(req.getContextPath() + "/?error=AccessDenied");
                    return;
                }
            }

            chain.doFilter(request, response); //Continue request normally
        } else {
            // Not logged in → go to login page
            res.sendRedirect(req.getContextPath() + "/login");
        }
    }
}
