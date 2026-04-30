package model;

import java.sql.Date;

public class Trabalhos{
    private int idTrabalho;
    private AlunoMateria alunoMateria;
    private String titulo;
    private Date dataEntregaPrevista;
    private Date dataEntregaAluno;
    private String situacao;

    public int getIdTrabalho(){return idTrabalho;}
    public void Trabalho(int idTrabalho){this.idTrabalho = idTrabalho;}

    public AlunoMateria getAlunoMateria(){return alunoMateria;}
    public void setAlunoMateria(AlunoMateria alunoMateria){this.alunoMateria = alunoMateria;}

    public String getTitulo(){return titulo;}
    public void setTitulo(String titulo){this.titulo = titulo;}

    public Date getDataEntregaPrevista(){return dataEntregaPrevista;}
    public void setDataEntregaPrevista(Date dataEntregaPrevista){this.dataEntregaPrevista = dataEntregaPrevista;}

    public Date getDataEntregaAluno(){return dataEntregaAluno;}
    public void setDataEntregaAluno(Date dataEntregaAluno){this.dataEntregaAluno = dataEntregaAluno;}

    public String getSituacao(){return situacao;}
    public void setSituacao(String situacao){this.situacao = situacao;}
}
