package conectores;

import conexao.ConexaoBD;
import model.Aluno;
import seguranca.GerenciadorSenha;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AlunoConector {

    public boolean cadastrarAluno(Aluno aluno) {
        String sql = "INSERT INTO Aluno (nome, email, senha, escolaridade) VALUES (?, ?, ?, ?)";
        try (Connection con = ConexaoBD.conectar();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            String senhaCriptografada=GerenciadorSenha.criptografar(aluno.getSenha());

            stmt.setString(1, aluno.getNome());
            stmt.setString(2, aluno.getEmail());
            stmt.setString(3, senhaCriptografada);
            stmt.setString(4, aluno.getEscolaridade());

            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.err.println("Erro ao salvar o aluno no banco: " + e.getMessage());
            return false;
        }
    }

    public Aluno autenticarLogin(String email, String senha) {
        String sql = "SELECT * FROM Aluno WHERE email = ?";
        try (Connection con = ConexaoBD.conectar();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String hashBDD=rs.getString("senha");

                if(GerenciadorSenha.verificar(senha, hashBDD)){
                    Aluno alunoLogado = new Aluno();
                    alunoLogado.setId(rs.getInt("id_aluno"));
                    alunoLogado.setNome(rs.getString("nome"));
                    alunoLogado.setEmail(rs.getString("email"));
                    alunoLogado.setSenha(rs.getString("senha"));
                    alunoLogado.setEscolaridade(rs.getString("escolaridade"));
                    alunoLogado.setCr(rs.getDouble("cr"));
                    return alunoLogado;
                }
            }
        } catch (SQLException e) {
            System.err.println("Erro na busca de login: " + e.getMessage());
        }
        return null;
    }

    public double crDinamico(int idAluno){
        String sql="SELECT CR FROM Aluno WHERE id_aluno=?";
        try (Connection con=ConexaoBD.conectar();
             PreparedStatement stmt=con.prepareStatement(sql)){

            stmt.setInt(1, idAluno);
            ResultSet rs=stmt.executeQuery();

            if(rs.next()) return rs.getDouble("CR");
        } catch (SQLException e){System.err.println("Erro na busca do CR: " + e.getMessage());}
        return 0.0;
    }
}
