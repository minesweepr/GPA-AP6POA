package conectores;

import conexao.ConexaoBD;
import model.Trabalho;
import state.EstadoFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TrabalhoConector {

    public List<Trabalho> listarPorAlunoMateria(int idAlunoMateria){
        List<Trabalho> lista = new ArrayList<>();
        String sql =
                "SELECT * FROM trabalhos " +
                        "WHERE id_aluno_materia = ? " +
                        "ORDER BY data_entrega_prevista ASC";

        try(Connection conn = ConexaoBD.conectar(); PreparedStatement ps = conn.prepareStatement(sql)){

            ps.setInt(1, idAlunoMateria);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                Trabalho t = new Trabalho();

                t.setIdTrabalho(rs.getInt("id_trabalho"));
                t.setIdAlunoMateria(rs.getInt("id_aluno_materia"));
                t.setTitulo(rs.getString("titulo"));

                Date entregaPrevista = rs.getDate("data_entrega_prevista");

                if(entregaPrevista != null){t.setDataEntregaPrevista(entregaPrevista.toLocalDate());}

                Date entregaAluno = rs.getDate("data_entrega_aluno");

                if(entregaAluno != null){t.setDataEntregaAluno(entregaAluno.toLocalDate());}

                t.setEstado(EstadoFactory.criar(rs.getString("situacao")));

                lista.add(t);
            }

        }catch(SQLException e){
            e.printStackTrace();
        }

        return lista;
    }

    public void inserir(Trabalho trabalho){

        String sql =
                "INSERT INTO trabalhos " +
                        "(" +
                        "id_aluno_materia, " +
                        "titulo, " +
                        "data_entrega_prevista, " +
                        "situacao, " +
                        "id_google_calendar" +
                        ") " +
                        "VALUES (?, ?, ?, ?, ?)";

        try(
                Connection conn = ConexaoBD.conectar();
                PreparedStatement ps = conn.prepareStatement(sql)
        ){
            ps.setInt(1, trabalho.getIdAlunoMateria());
            ps.setString(2, trabalho.getTitulo());

            if (trabalho.getDataEntregaPrevista() != null) {
                ps.setDate(3, Date.valueOf(trabalho.getDataEntregaPrevista()));
            } else {
                ps.setNull(3, Types.DATE);
            }

            ps.setString(4, trabalho.getEstado().getNome());
            ps.setString(5, trabalho.getIdGoogleCalendar());

            ps.executeUpdate();

        }catch(SQLException e){
            e.printStackTrace();
        }
    }

    public void excluir(int idTrabalho){

        String sql =
                "DELETE FROM trabalhos " +
                        "WHERE id_trabalho = ?";

        try(Connection conn = ConexaoBD.conectar();
            PreparedStatement ps =
                    conn.prepareStatement(sql)){

            ps.setInt(1, idTrabalho);

            ps.executeUpdate();

        }catch(SQLException e){
            e.printStackTrace();
        }
    }

    public void atualizar(Trabalho trabalho) {

        String sql =
                "UPDATE trabalhos " +
                        "SET " +
                        "id_aluno_materia = ?, " +
                        "titulo = ?, " +
                        "data_entrega_prevista = ? " +
                        "WHERE id_trabalho = ?";

        try (Connection conn = ConexaoBD.conectar(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, trabalho.getIdAlunoMateria());
            ps.setString(2, trabalho.getTitulo());

            if (trabalho.getDataEntregaPrevista() != null) {
                ps.setDate(3, Date.valueOf(trabalho.getDataEntregaPrevista()));
            } else {
                ps.setNull(3, Types.DATE);
            }

            ps.setInt(4, trabalho.getIdTrabalho());

            int linhas = ps.executeUpdate();
            if (linhas == 0) {
                System.out.println("Nenhuma atividade encontrada para atualizar.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void entregar(int idTrabalho) {

        String sql =
                "UPDATE trabalhos " +
                        "SET situacao = ?, " +
                        "data_entrega_aluno = ? " +
                        "WHERE id_trabalho = ?";

        try (Connection conn = ConexaoBD.conectar(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "entregue");
            ps.setDate(2, Date.valueOf(java.time.LocalDate.now()));
            ps.setInt(3, idTrabalho);

            int linhas = ps.executeUpdate();

            if (linhas == 0) {
                System.out.println("Nenhuma atividade encontrada.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void atualizarIdGoogleCalendar(int idTrabalho, String eventId) {

        String sql =
                "UPDATE trabalhos " +
                        "SET id_google_calendar = ? " +
                        "WHERE id_trabalho = ?";

        try (Connection conn = ConexaoBD.conectar(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, eventId);
            stmt.setInt(2, idTrabalho);

            int linhas = stmt.executeUpdate();


            System.out.println("LINHAS: " + linhas);
            System.out.println("EVENT ID SQL: " + eventId);
            System.out.println("TRABALHO SQL: " + idTrabalho);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Trabalho> listarPorSemestre(int idAluno, int idSemestre){

        List<Trabalho> lista = new ArrayList<>();

        String sql =
                "SELECT t.* " +
                        "FROM trabalhos t " +
                        "JOIN aluno_materia am " +
                        "ON t.id_aluno_materia = am.id_aluno_materia " +
                        "JOIN semestre s " +
                        "ON am.id_semestre = s.id_semestre " +
                        "WHERE s.id_aluno = ? " +
                        "AND am.id_semestre = ? " +
                        "ORDER BY " +
                        "t.data_entrega_prevista ASC";

        try(Connection conn = ConexaoBD.conectar(); PreparedStatement ps = conn.prepareStatement(sql)){

            ps.setInt(1, idAluno);
            ps.setInt(2, idSemestre);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){

                Trabalho t = new Trabalho();

                t.setIdTrabalho(rs.getInt("id_trabalho"));

                t.setIdAlunoMateria(rs.getInt("id_aluno_materia"));

                t.setTitulo(rs.getString("titulo"));

                Date entregaPrevista = rs.getDate("data_entrega_prevista");
                if (entregaPrevista != null) {
                    t.setDataEntregaPrevista(entregaPrevista.toLocalDate());
                }

                Date entregaAluno = rs.getDate("data_entrega_aluno");

                if(entregaAluno != null){t.setDataEntregaAluno(entregaAluno.toLocalDate());}

                t.setEstado(EstadoFactory.criar(rs.getString("situacao")));

                lista.add(t);
            }

        }catch(SQLException e){
            e.printStackTrace();
        }

        return lista;
    }

    public Trabalho buscarPorId(int idTrabalho) {

        String sql = "SELECT * " + "FROM trabalhos " + "WHERE id_trabalho = ?";

        Trabalho trabalho = null;

        try (Connection conn = ConexaoBD.conectar(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idTrabalho);
            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    trabalho = new Trabalho();
                    trabalho.setIdTrabalho(rs.getInt("id_trabalho"));

                    trabalho.setIdAlunoMateria(rs.getInt("id_aluno_materia"));
                    trabalho.setTitulo(rs.getString("titulo"));

                    Date dataPrevista = rs.getDate("data_entrega_prevista");

                    if (dataPrevista != null) {
                        trabalho.setDataEntregaPrevista(dataPrevista.toLocalDate());}

                    Date dataAluno = rs.getDate("data_entrega_aluno");

                    if (dataAluno != null) {
                        trabalho.setDataEntregaAluno(dataAluno.toLocalDate());}

                    trabalho.setIdGoogleCalendar(rs.getString("id_google_calendar"));
                }

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return trabalho;
    }
}