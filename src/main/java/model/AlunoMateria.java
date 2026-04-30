package model;

public class AlunoMateria{
    private int idAlunoMateria;
    private Semestre semestre;
    private Materia materia;

    public int getIdAlunoMateria(){return idAlunoMateria;}
    public void setIdAlunoMateria(int idAlunoMateria){this.idAlunoMateria = idAlunoMateria;}

    public Semestre getSemestre(){return semestre;}
    public void setSemestre(Semestre semestre){this.semestre = semestre;}

    public Materia getMateria(){return materia;}
    public void setMateria(Materia materia){this.materia = materia;}

}
