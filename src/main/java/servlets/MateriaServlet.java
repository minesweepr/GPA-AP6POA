package servlets;

import conectores.MateriaConector;
import model.Materia;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/MateriaServlet")
public class MateriaServlet extends HttpServlet{
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // dados
        javax.servlet.http.HttpSession session=request.getSession();
        model.Aluno alunoSessao=(model.Aluno) session.getAttribute("alunoAtivo");
        if(alunoSessao==null){response.sendRedirect("login.jsp"); return;}

        String idStr=request.getParameter("idMateria");
        String nome=request.getParameter("nome");
        String sigla=request.getParameter("sigla");
        String creditosStr=request.getParameter("creditos");

        MateriaConector materiaDao=new MateriaConector();
        Materia materia=new Materia();

        try{
            materia.setNome(nome);
            materia.setSigla(sigla);
            materia.setCreditos(Integer.parseInt(creditosStr));
            materia.setAluno(alunoSessao);

            // logica salvar ou editar
            if(idStr!=null && !idStr.isEmpty()){
                materia.setIdMateria(Integer.parseInt(idStr));
                materiaDao.alterar(materia);
            }else materiaDao.inserir(materia);

        }catch(Exception e){e.printStackTrace();}

        String semestreId = request.getParameter("semestreId");
        response.sendRedirect("notas.jsp?semestreId=" + semestreId);
    }
}