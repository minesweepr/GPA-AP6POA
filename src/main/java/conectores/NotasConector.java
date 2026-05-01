package conectores;

import conexao.ConexaoBD;
import model.AlunoMateria;
import model.Materia;
import model.Notas;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotasConector {
    public List<Notas> listarNotasPorSemestre(int idAluno, int idSemestre) {
        List<Notas> lista=new ArrayList<>();
        String sql="SELECT am.id_aluno_materia, m.nome as nome_materia, n.id_nota, n.av1, n.av2, n.avf, n.mf " +
                "FROM aluno_materia am " + "JOIN materia m ON am.id_materia = m.id_materia " +
                "JOIN semestre s ON am.id_semestre = s.id_semestre " +
                "LEFT JOIN notas n ON am.id_aluno_materia = n.id_aluno_materia " +
                "WHERE s.id_aluno = ? AND am.id_semestre = ?";

        try(Connection con=ConexaoBD.conectar();
             PreparedStatement stmt=con.prepareStatement(sql)){
            stmt.setInt(1, idAluno);
            stmt.setInt(2, idSemestre);
            ResultSet rs=stmt.executeQuery();

            while(rs.next()){
                Notas nota=new Notas();
                AlunoMateria am=new AlunoMateria();
                Materia m=new Materia();

                am.setIdAlunoMateria(rs.getInt("id_aluno_materia"));
                m.setNome(rs.getString("nome_materia"));
                am.setMateria(m);
                nota.setAlunoMateria(am);

                nota.setIdNota(rs.getInt("id_nota"));

                //getDouble pra evitar erro de cast com BigDecimal
                nota.setAv1(rs.getDouble("av1"));
                nota.setAv2(rs.getDouble("av2"));
                nota.setAvf(rs.getDouble("avf"));
                nota.setMf(rs.getDouble("mf"));

                lista.add(nota);
            }
        }catch (SQLException e) {e.printStackTrace();}
        return lista;
    }
}