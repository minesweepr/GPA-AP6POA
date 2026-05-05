package conectores;

import conexao.ConexaoBD;
import model.Materia;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MateriaConector {
    // Retorna todas as disciplinas oferecidas
    public List<Materia> listarTodas() {
        List<Materia> lista = new ArrayList<>();
        String sql = "SELECT * FROM materia";
        try (Connection con = ConexaoBD.conectar();
             PreparedStatement stmt = con.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Materia m = new Materia();
                m.setIdMateria(rs.getInt("id_materia"));
                m.setNome(rs.getString("nome"));
                m.setSigla(rs.getString("sigla"));
                m.setCreditos(rs.getInt("creditos"));
                lista.add(m);
            }
        } catch (SQLException e) {
            System.err.println("Erro ao listar materias: " + e.getMessage());
        }
        return lista;
    }

    public void inserir(Materia materia){
        String sql="INSERT INTO materia (nome, sigla, creditos) VALUES (?, ?, ?)";
        try(Connection conn = ConexaoBD.conectar();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, materia.getNome());
            ps.setString(2, materia.getSigla());
            ps.setInt(3, materia.getCreditos());

            ps.executeUpdate();
        }catch (SQLException e){e.printStackTrace();}
    }

    public void alterar(Materia materia){
        String sql="UPDATE materia SET nome = ?, sigla = ?, creditos = ? WHERE id_materia = ?";
        try(Connection conn=ConexaoBD.conectar();
            PreparedStatement ps=conn.prepareStatement(sql)){
            ps.setString(1, materia.getNome());
            ps.setString(2, materia.getSigla());
            ps.setInt(3, materia.getCreditos());
            ps.setInt(4, materia.getIdMateria());

            ps.executeUpdate();
        }catch (SQLException e){e.printStackTrace();}
    }

    public List<Integer> listarMateriaPorSemestre(int idAluno, int idSemestre){
        List<Integer> ids=new ArrayList<>();
        String sql="SELECT am.id_materia FROM aluno_materia am " + "JOIN semestre s ON am.id_semestre = s.id_semestre "
                   + "WHERE s.id_aluno = ? AND am.id_semestre = ?";

        try(Connection con=ConexaoBD.conectar();
            PreparedStatement stmt=con.prepareStatement(sql)){
            stmt.setInt(1, idAluno);
            stmt.setInt(2, idSemestre);

            ResultSet rs=stmt.executeQuery();
            while(rs.next()){ids.add(rs.getInt("id_materia"));}
        }catch(SQLException e){System.err.println("Erro ao buscar materias selecionadas: " + e.getMessage());}
        return ids;
    }

    public double buscarMediaMateria(int idMateria, int idSemestre){
        double media=0.0;
        String sql="SELECT n.mf FROM notas n " + "JOIN aluno_materia am ON n.id_aluno_materia = am.id_aluno_materia "
                + "WHERE am.id_materia = ? AND am.id_semestre = ?";

        try(Connection con=ConexaoBD.conectar();
            PreparedStatement stmt=con.prepareStatement(sql)){
            stmt.setInt(1, idMateria);
            stmt.setInt(2, idSemestre);
            ResultSet rs= stmt.executeQuery();
            if(rs.next()){
                media=rs.getDouble("mf");
            }
        }catch(SQLException e){e.printStackTrace();}
        return media;
    }

    public void vincularMateriaSemestre(int idMateria, int idSemestre){
        String sql="INSERT INTO aluno_materia (id_materia, id_semestre) VALUES (?, ?)";
        try(Connection con=ConexaoBD.conectar();
            PreparedStatement stmt=con.prepareStatement(sql)){
            stmt.setInt(1, idMateria);
            stmt.setInt(2, idSemestre);
            stmt.executeUpdate();
        }catch(SQLException e){e.printStackTrace();}
    }
}