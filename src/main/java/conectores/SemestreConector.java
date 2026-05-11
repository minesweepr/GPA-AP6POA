package conectores;

import conexao.ConexaoBD;
import model.Materia;
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
                s.setDesempenho(rs.getDouble("desempenho"));
                lista.add(s);
            }
        }catch (SQLException e) {System.err.println("Erro ao listar semestres: " + e.getMessage());}
        return lista;
    }

    public void inserir(Semestre semestre){
        String sql="INSERT INTO semestre (id_aluno, titulo) VALUES (?, ?)";
        try(Connection conn = ConexaoBD.conectar();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, semestre.getAluno().getId());
            ps.setString(2, semestre.getTitulo());

            ps.executeUpdate();
        }catch (SQLException e){e.printStackTrace();}
    }

    public void alterar(Semestre semestre){
        String sql="UPDATE semestre SET titulo = ? WHERE id_semestre = ?";
        try(Connection conn=ConexaoBD.conectar();
            PreparedStatement ps=conn.prepareStatement(sql)){
            ps.setString(1, semestre.getTitulo());
            ps.setInt(2, semestre.getIdSemestre());

            ps.executeUpdate();
        }catch (SQLException e){e.printStackTrace();}
    }

    public void excluir(int idSemestre, int idAluno){
        String sql="DELETE FROM semestre WHERE id_semestre = ? AND id_aluno = ?";
        try(Connection conn=ConexaoBD.conectar();
            PreparedStatement ps=conn.prepareStatement(sql)){
            ps.setInt(1, idSemestre);
            ps.setInt(2, idAluno);

            ps.execute();
        }catch (SQLException e){e.printStackTrace();}
    }
}