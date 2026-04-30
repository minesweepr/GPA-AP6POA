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


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email=request.getParameter("emailAluno");
        String senha=request.getParameter("senhaAluno");

        AlunoConector dao=new AlunoConector();
        Aluno alunoLogado=dao.autenticarLogin(email, senha);

        if(alunoLogado!=null){
            HttpSession sessao = request.getSession();
            sessao.setAttribute("alunoAtivo", alunoLogado);
            response.sendRedirect("index.jsp");
        }else{
            request.setAttribute("erroLogin", "Credenciais inválidas!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}