package model;

public class Notas{
    private int idNota;
    private AlunoMateria alunoMateria;
    private double av1;
    private double av2;
    private double avf;
    private double mf;

    public int getIdNota(){return idNota;}
    public void setIdNota(int idNota){this.idNota = idNota;}

    public AlunoMateria getAlunoMateria(){return alunoMateria;}
    public void setAlunoMateria(AlunoMateria alunoMateria){this.alunoMateria = alunoMateria;}

    public double getAv1(){return av1;}
    public void setAv1(double av1){this.av1 = av1;}

    public double getAv2(){return av2;}
    public void setAv2(double av2){this.av2 = av2;}

    public double getAvf(){return avf;}
    public void setAvf(double avf){this.avf = avf;}

    public double getMf(){return mf;}
    public void setMf(double mf){this.mf = mf;}
}
