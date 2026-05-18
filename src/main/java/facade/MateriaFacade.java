package facade;

import conectores.MateriaConector;
import model.Aluno;
import model.Materia;

public class MateriaFacade {
    public void salvarOuEditarMateria(
            String idStr,
            String nome,
            String sigla,
            String creditosStr,
            Aluno aluno
    ) {
        try {
            Materia materia = new Materia();

            materia.setNome(nome);
            materia.setSigla(sigla);
            materia.setCreditos(Integer.parseInt(creditosStr));

            materia.setAluno(aluno);
            MateriaConector dao = new MateriaConector();

            if (idStr != null && !idStr.isEmpty()) {
                materia.setIdMateria(Integer.parseInt(idStr));
                dao.alterar(materia);
            } else {
                dao.inserir(materia);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void vincularMateriaSemestre(int idMateria, int idSemestre) {
        MateriaConector dao = new MateriaConector();
        dao.vincularMateriaSemestre(idMateria, idSemestre);
    }
}