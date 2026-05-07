package model;

public class Notas{
    private int idNota;
    private AlunoMateria alunoMateria;
    private Double av1;
    private Double av2;
    private Double avf;
    private Double mf;

    public int getIdNota(){return idNota;}
    public void setIdNota(int idNota){this.idNota = idNota;}

    public AlunoMateria getAlunoMateria(){return alunoMateria;}
    public void setAlunoMateria(AlunoMateria alunoMateria){this.alunoMateria = alunoMateria;}

    public Double getAv1(){return av1;}
    public void setAv1(Double av1){this.av1 = av1;}

    public Double getAv2(){return av2;}
    public void setAv2(Double av2){this.av2 = av2;}

    public Double getAvf(){return avf;}
    public void setAvf(Double avf){this.avf = avf;}

    public Double getMf(){return mf;}
    public void setMf(Double mf){this.mf = mf;}
}