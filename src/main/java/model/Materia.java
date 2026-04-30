package model;

public class Materia{
    private int idMtaeria;
    private String sigla;
    private String nome;
    private int creditos;;

    public int getIdMtaeria(){return idMtaeria;}
    public void setIdMtaeria(int idMtaeria){this.idMtaeria = idMtaeria;}

    public String getSigla(){return sigla;}
    public void setSigla(String sigla){this.sigla = sigla;}

    public String getNome(){return nome;}
    public void setNome(String nome){this.nome = nome;}

    public int getCreditos(){return creditos;}
    public void setCreditos(int creditos){this.creditos = creditos;}
}
