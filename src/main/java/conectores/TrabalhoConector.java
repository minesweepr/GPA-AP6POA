package conectores;

import conexao.ConexaoBD;
import model.Trabalho;
import state.EstadoFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TrabalhoConector {

    public List<Trabalho> listarPorAlunoMateria(
            int idAlunoMateria
    ){

        List<Trabalho> lista =
                new ArrayList<>();

        String sql =
                "SELECT * FROM trabalhos " +
                        "WHERE id_aluno_materia = ? " +
                        "ORDER BY data_entrega_prevista ASC";

        try(
                Connection conn =
                        ConexaoBD.conectar();

                PreparedStatement ps =
                        conn.prepareStatement(sql)
        ){

            ps.setInt(1, idAlunoMateria);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()){

                Trabalho t =
                        new Trabalho();

                t.setIdTrabalho(
                        rs.getInt(
                                "id_trabalho"
                        )
                );

                t.setIdAlunoMateria(
                        rs.getInt(
                                "id_aluno_materia"
                        )
                );

                t.setTitulo(
                        rs.getString(
                                "titulo"
                        )
                );

                Date entregaPrevista =
                        rs.getDate(
                                "data_entrega_prevista"
                        );

                if(entregaPrevista != null){
                    t.setDataEntregaPrevista(
                            entregaPrevista
                                    .toLocalDate()
                    );
                }

                Date entregaAluno =
                        rs.getDate(
                                "data_entrega_aluno"
                        );

                if(entregaAluno != null){
                    t.setDataEntregaAluno(
                            entregaAluno
                                    .toLocalDate()
                    );
                }

                t.setEstado(
                        EstadoFactory.criar(
                                rs.getString(
                                        "situacao"
                                )
                        )
                );

                lista.add(t);
            }

        }catch(SQLException e){
            e.printStackTrace();
        }

        return lista;
    }

    public void inserir(
            Trabalho trabalho
    ){

        String sql =
                "INSERT INTO trabalhos " +
                        "(" +
                        "id_aluno_materia, " +
                        "titulo, " +
                        "data_entrega_prevista, " +
                        "situacao" +
                        ") " +
                        "VALUES (?, ?, ?, ?)";

        try(
                Connection conn =
                        ConexaoBD.conectar();

                PreparedStatement ps =
                        conn.prepareStatement(sql)
        ){

            ps.setInt(
                    1,
                    trabalho.getIdAlunoMateria()
            );

            ps.setString(
                    2,
                    trabalho.getTitulo()
            );

            ps.setDate(
                    3,
                    Date.valueOf(
                            trabalho
                                    .getDataEntregaPrevista()
                    )
            );

            ps.setString(
                    4,
                    trabalho
                            .getEstado()
                            .getNome()
            );

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

            ps.execute();

        }catch(SQLException e){
            e.printStackTrace();
        }
    }

    public List<Trabalho>
    listarPorSemestre(
            int idAluno,
            int idSemestre
    ){

        List<Trabalho> lista =
                new ArrayList<>();

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

        try(
                Connection conn =
                        ConexaoBD.conectar();

                PreparedStatement ps =
                        conn.prepareStatement(sql)
        ){

            ps.setInt(1, idAluno);
            ps.setInt(2, idSemestre);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()){

                Trabalho t =
                        new Trabalho();

                t.setIdTrabalho(
                        rs.getInt(
                                "id_trabalho"
                        )
                );

                t.setIdAlunoMateria(
                        rs.getInt(
                                "id_aluno_materia"
                        )
                );

                t.setTitulo(
                        rs.getString(
                                "titulo"
                        )
                );

                t.setDataEntregaPrevista(
                        rs.getDate(
                                "data_entrega_prevista"
                        ).toLocalDate()
                );

                Date entregaAluno =
                        rs.getDate(
                                "data_entrega_aluno"
                        );

                if(entregaAluno != null){
                    t.setDataEntregaAluno(
                            entregaAluno
                                    .toLocalDate()
                    );
                }

                t.setEstado(
                        EstadoFactory.criar(
                                rs.getString(
                                        "situacao"
                                )
                        )
                );

                lista.add(t);
            }

        }catch(SQLException e){
            e.printStackTrace();
        }

        return lista;
    }
}