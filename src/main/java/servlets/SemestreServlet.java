package servlets;

import conectores.SemestreConector;
import model.Semestre;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/SemestreServlet")
public class SemestreServlet extends HttpServlet{
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // dados
        javax.servlet.http.HttpSession session=request.getSession();
        model.Aluno alunoSessao=(model.Aluno) session.getAttribute("alunoAtivo");
        if(alunoSessao==null){response.sendRedirect("login.jsp"); return;}

        String idStr=request.getParameter("idSemestre");
        String titulo=request.getParameter("nome");

        SemestreConector semestreDao=new SemestreConector();
        Semestre semestre=new Semestre();

        try{
            semestre.setTitulo(titulo);
            semestre.setAluno(alunoSessao);

            // logica salvar ou editar
            if(idStr!=null && !idStr.isEmpty()){
                semestre.setIdSemestre(Integer.parseInt(idStr));
                semestreDao.alterar(semestre);
            }else semestreDao.inserir(semestre);

        }catch(Exception e){e.printStackTrace();}

        String referer=request.getHeader("Referer");

        if(referer!=null && !referer.isEmpty()) response.sendRedirect(referer);
        else response.sendRedirect("index.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        request.setCharacterEncoding("UTF-8");

        // dados
        javax.servlet.http.HttpSession session=request.getSession();
        model.Aluno alunoSessao=(model.Aluno) session.getAttribute("alunoAtivo");
        if(alunoSessao==null){response.sendRedirect("login.jsp"); return;}

        String idExcluir=request.getParameter("excluirId");
        if(idExcluir!=null && alunoSessao!=null){
            SemestreConector dao=new SemestreConector();
            dao.excluir(Integer.parseInt(idExcluir), alunoSessao.getId());
        }

        String referer=request.getHeader("Referer");

        if(referer!=null && !referer.isEmpty()) response.sendRedirect(referer);
        else response.sendRedirect("index.jsp");
    }
}