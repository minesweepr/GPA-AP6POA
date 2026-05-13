package conectores;

import conexao.ConexaoBD;
import model.AlunoMateria;
import model.Materia;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AlunoMateriaConector {

    public List<AlunoMateria> listarPorSemestre(
            int idAluno,
            int idSemestre
    ){

        List<AlunoMateria> lista =
                new ArrayList<>();

        String sql =
                "SELECT " +
                        "am.id_aluno_materia, " +
                        "m.id_materia, " +
                        "m.nome, " +
                        "m.sigla, " +
                        "m.creditos " +
                        "FROM aluno_materia am " +
                        "JOIN materia m " +
                        "ON am.id_materia = m.id_materia " +
                        "JOIN semestre s " +
                        "ON am.id_semestre = s.id_semestre " +
                        "WHERE s.id_aluno = ? " +
                        "AND am.id_semestre = ? " +
                        "ORDER BY m.nome";

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

                Materia materia =
                        new Materia();

                materia.setIdMateria(
                        rs.getInt(
                                "id_materia"
                        )
                );

                materia.setNome(
                        rs.getString(
                                "nome"
                        )
                );

                materia.setSigla(
                        rs.getString(
                                "sigla"
                        )
                );

                materia.setCreditos(
                        rs.getInt(
                                "creditos"
                        )
                );

                AlunoMateria am =
                        new AlunoMateria();

                am.setIdAlunoMateria(
                        rs.getInt(
                                "id_aluno_materia"
                        )
                );

                am.setMateria(
                        materia
                );

                lista.add(am);
            }

        }catch(SQLException e){

            System.err.println(
                    "Erro ao listar materias do semestre: "
                            + e.getMessage()
            );
        }

        return lista;
    }
}