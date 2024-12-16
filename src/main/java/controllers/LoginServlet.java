package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.LoginService;
import service.LoginServiceSessionImplement;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Optional;

@WebServlet({"/login", "/login.html"})
public class LoginServlet extends HttpServlet {
    // Usuarios con permisos
    final static String USERNAME = "admin";
    final static String PASSWORD = "12345";

    // Usuario normal (sin permisos especiales)
    final static String NORMAL_USER = "usuario";
    final static String NORMAL_PASSWORD = "123";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Implementación de la sesión
        LoginService auth = new LoginServiceSessionImplement();
        Optional<String> usernameOptional = auth.getUsername(req);

        if (usernameOptional.isPresent()) {
            // Si el usuario está autenticado, mostrar la página de bienvenida
            String username = usernameOptional.get();
            String role = (String) req.getSession().getAttribute("role");

            resp.setContentType("text/html;charset=UTF-8");
            try (PrintWriter out = resp.getWriter()) {
                // HTML con Bootstrap
                out.print("<!DOCTYPE html>");
                out.println("<html lang='es'>");
                out.println("<head>");
                out.println("<meta charset='UTF-8'>");
                out.println("<meta name='viewport' content='width=device-width, initial-scale=1'>");
                out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css' rel='stylesheet'>");
                out.println("<title>Hola " + username + "</title>");
                out.println("</head>");
                out.println("<body>");
                out.println("<div class='container mt-5'>");
                out.println("<h1 class='text-center'>Hola " + username + ", ya has iniciado sesión anteriormente</h1>");
                out.println("<div class='text-center mt-4'>");
                out.println("<a class='btn btn-primary' href='" + req.getContextPath() + "/index.html'>Volver al inicio</a>");
                out.println("<a class='btn btn-danger ms-2' href='" + req.getContextPath() + "/logout'>Cerrar sesión</a>");
                out.println("</div>");
                out.println("</div>");

                // Si el usuario es normal, no mostrar opciones de administración
                if ("user".equals(role)) {
                    out.println("<p class='text-center mt-4'>No tienes permisos para ver pedidos ni realizar acciones administrativas.</p>");
                }

                out.println("<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js'></script>");
                out.println("</body>");
                out.println("</html>");
            }
        } else {
            // Si el usuario no está autenticado, redirigir al formulario de login
            getServletContext().getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        HttpSession session = req.getSession();

        if (USERNAME.equals(username) && PASSWORD.equals(password)) {
            // Usuario administrador
            session.setAttribute("username", username);
            session.setAttribute("role", "admin");
            resp.sendRedirect(req.getContextPath() + "/login.html");
        } else if (NORMAL_USER.equals(username) && NORMAL_PASSWORD.equals(password)) {
            // Usuario normal
            session.setAttribute("username", username);
            session.setAttribute("role", "user");
            resp.sendRedirect(req.getContextPath() + "/login.html");
        } else {
            // Si las credenciales son incorrectas, mostrar un error
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Lo sentimos, no estás autorizado para ingresar a esta página!");
        }
    }
}
