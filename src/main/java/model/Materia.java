package model;

public class Materia{
    private int idMateria;
    private String sigla;
    private String nome;
    private int creditos;
    private Aluno aluno;

    public int getIdMateria(){return idMateria;}
    public void setIdMateria(int idMateria){this.idMateria = idMateria;}

    public String getSigla(){return sigla;}
    public void setSigla(String sigla){this.sigla = sigla;}

    public String getNome(){return nome;}
    public void setNome(String nome){this.nome = nome;}

    public int getCreditos(){return creditos;}
    public void setCreditos(int creditos){this.creditos = creditos;}

    public Aluno getAluno(){return aluno;}
    public void setAluno(Aluno aluno){this.aluno = aluno;}
}
