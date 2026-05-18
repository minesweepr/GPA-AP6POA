package servlets;

import facade.MateriaFacade;
import model.Aluno;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/VincularMateriaServlet")
public class VincularMateriaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        Aluno alunoSessao = (Aluno) session.getAttribute("alunoAtivo");

        if (alunoSessao == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int idMateria = Integer.parseInt(request.getParameter("idMateria"));
        int idSemestre = Integer.parseInt(request.getParameter("idSemestre"));

        MateriaFacade facade = new MateriaFacade();
        facade.vincularMateriaSemestre(idMateria, idSemestre);

        response.sendRedirect("notas.jsp?semestreId=" + idSemestre);
    }
}