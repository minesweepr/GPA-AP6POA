package servlets;

import conectores.AlunoConector;
import model.Aluno;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


@WebServlet("/CadastroServlet")
public class CadastroServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String nome=request.getParameter("nomeAluno");
        String escolaridade=request.getParameter("escolaridadeAluno");
        String email=request.getParameter("emailAluno");
        String senha=request.getParameter("senhaAluno");

        Aluno aluno=new Aluno();
        aluno.setNome(nome);
        aluno.setEscolaridade(escolaridade);
        aluno.setEmail(email);
        aluno.setSenha(senha);

        AlunoConector dao = new AlunoConector();
        try{
            dao.cadastrarAluno(aluno);
            response.sendRedirect("login.jsp?sucesso=1");
        }catch(Exception e){
            request.setAttribute("erroCadastro", "erro ao cadastrar o usuário");
            request.getRequestDispatcher("cadastro.jsp").forward(request, response);
        }
    }
}