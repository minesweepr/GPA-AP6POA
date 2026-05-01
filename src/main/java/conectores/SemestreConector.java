package conectores;

import conexao.ConexaoBD;
import model.Semestre;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SemestreConector {
    public List<Semestre> listarPorAluno(int idAluno){
        List<Semestre> lista=new ArrayList<>();
        String sql="SELECT * FROM semestre WHERE id_aluno = ? ORDER BY titulo DESC";

        try(Connection con=ConexaoBD.conectar();
             PreparedStatement stmt=con.prepareStatement(sql)){
            stmt.setInt(1, idAluno);
            ResultSet rs=stmt.executeQuery();

            while(rs.next()){
                Semestre s=new Semestre();
                s.setIdSemestre(rs.getInt("id_semestre"));
                s.setTitulo(rs.getString("titulo"));
                lista.add(s);
            }
        }catch (SQLException e) {System.err.println("Erro ao listar semestres: " + e.getMessage());}
        return lista;
    }
}