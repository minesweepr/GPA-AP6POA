package model;

public class Semestre{
    private int idSemestre;
    private Aluno aluno;
    private String titulo;
    private double desempenho;

    public int getIdSemestre(){return idSemestre;}
    public void setIdSemestre(int idSemestre){this.idSemestre = idSemestre;}

    public Aluno getAluno(){return aluno;}
    public void setAluno(Aluno aluno){this.aluno = aluno;}

    public String getTitulo(){return titulo;}
    public void setTitulo(String titulo){this.titulo = titulo;}

    public double getDesempenho(){return desempenho;}
    public void setDesempenho(double desempenho){this.desempenho = desempenho;}
}
