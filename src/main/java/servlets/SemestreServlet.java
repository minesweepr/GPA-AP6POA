package servlets;

import facade.SemestreFacade;
import model.Aluno;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/SemestreServlet")
public class SemestreServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Aluno alunoSessao = (Aluno) session.getAttribute("alunoAtivo");

        if (alunoSessao == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String idStr = request.getParameter("idSemestre");

        String titulo = request.getParameter("nome");

        SemestreFacade facade = new SemestreFacade();

        facade.salvarOuEditar(idStr, titulo, alunoSessao);

        String referer = request.getHeader("Referer");
        if (referer != null && !referer.isEmpty()) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        Aluno alunoSessao = (Aluno) session.getAttribute("alunoAtivo");

        if (alunoSessao == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String idExcluir = request.getParameter("excluirId");

        SemestreFacade facade = new SemestreFacade();
        facade.excluir(idExcluir, alunoSessao.getId());
        String referer = request.getHeader("Referer");

        if (referer != null && !referer.isEmpty()) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect("index.jsp");
        }
    }
}