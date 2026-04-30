package conectores;

import conexao.ConexaoBD;
import model.Aluno;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AlunoConector {

    public boolean cadastrarAluno(Aluno aluno) {
        String sql = "INSERT INTO Aluno (nome, email, senha, escolaridade) VALUES (?, ?, ?, ?)";
        try (Connection con = ConexaoBD.conectar();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, aluno.getNome());
            stmt.setString(2, aluno.getEmail());
            stmt.setString(3, aluno.getSenha());
            stmt.setString(4, aluno.getEscolaridade());

            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.err.println("Erro ao salvar o aluno no banco: " + e.getMessage());
            return false;
        }
    }

    public Aluno autenticarLogin(String email, String senha) {
        String sql = "SELECT * FROM Aluno WHERE email = ? AND senha = ?";
        try (Connection con = ConexaoBD.conectar();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setString(2, senha);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Aluno alunoLogado = new Aluno();
                alunoLogado.setNome(rs.getString("nome"));
                alunoLogado.setEmail(rs.getString("email"));
                alunoLogado.setSenha(rs.getString("senha"));
                alunoLogado.setEscolaridade(rs.getString("escolaridade"));
                return alunoLogado;
            }
        } catch (SQLException e) {
            System.err.println("Erro na busca de login: " + e.getMessage());
        }
        return null;
    }
}
