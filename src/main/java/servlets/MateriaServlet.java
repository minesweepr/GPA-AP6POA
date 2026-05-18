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

@WebServlet("/MateriaServlet")
public class MateriaServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Aluno alunoSessao = (Aluno) session.getAttribute("alunoAtivo");

        if (alunoSessao == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String idStr = request.getParameter("idMateria");
        String nome = request.getParameter("nome");
        String sigla =  request.getParameter("sigla");
        String creditosStr = request.getParameter("creditos");

        MateriaFacade facade = new MateriaFacade();
        facade.salvarOuEditarMateria(
                idStr,
                nome,
                sigla,
                creditosStr,
                alunoSessao
        );

        String semestreId = request.getParameter("semestreId");
        response.sendRedirect("notas.jsp?semestreId=" + semestreId);
    }
}