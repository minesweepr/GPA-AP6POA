package facade;

import conectores.SemestreConector;
import model.Aluno;
import model.Semestre;

public class SemestreFacade {
    public void salvarOuEditar(String idStr, String titulo, Aluno aluno) {
        try {
            Semestre semestre = new Semestre();
            semestre.setTitulo(titulo);
            semestre.setAluno(aluno);
            SemestreConector dao = new SemestreConector();

            if (idStr != null && !idStr.isEmpty()) {
                semestre.setIdSemestre(Integer.parseInt(idStr));
                dao.alterar(semestre);
            } else {
                dao.inserir(semestre);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void excluir(String idExcluir, int idAluno) {
        if (idExcluir != null) {
            SemestreConector dao = new SemestreConector();
            dao.excluir(Integer.parseInt(idExcluir), idAluno);
        }
    }
}