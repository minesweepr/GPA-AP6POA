package servlets;

import conectores.MateriaConector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/VincularMateriaServlet")
public class VincularMateriaServlet extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        javax.servlet.http.HttpSession session=request.getSession();
        model.Aluno alunoSessao=(model.Aluno) session.getAttribute("alunoAtivo");
        if(alunoSessao==null){response.sendRedirect("login.jsp"); return;}

        int idMateria=Integer.parseInt(request.getParameter("idMateria"));
        int idSemestre=Integer.parseInt(request.getParameter("idSemestre"));

        MateriaConector dao=new MateriaConector();
        dao.vincularMateriaSemestre(idMateria, idSemestre);

        response.sendRedirect("notas.jsp?semestreId=" + idSemestre);
    }
}