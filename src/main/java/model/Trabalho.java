package model;

import state.*;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Trabalho {

    private int idTrabalho;
    private int idAlunoMateria;

    private String titulo;

    private LocalDate dataEntregaPrevista;
    private LocalDate dataEntregaAluno;

    private EstadoTrabalho estado;

    private String idGoogleCalendar;

    public int getIdTrabalho() {
        return idTrabalho;
    }

    public void setIdTrabalho(int idTrabalho) {
        this.idTrabalho = idTrabalho;
    }

    public int getIdAlunoMateria() {
        return idAlunoMateria;
    }

    public void setIdAlunoMateria(int idAlunoMateria) {
        this.idAlunoMateria = idAlunoMateria;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public LocalDate getDataEntregaPrevista() {
        return dataEntregaPrevista;
    }

    public String getDataEntregaPrevistaFormatada() {

        if (dataEntregaPrevista == null) return "";

        return dataEntregaPrevista.format(
                DateTimeFormatter.ofPattern("dd/MM/yyyy")
        );
    }

    public void setDataEntregaPrevista(LocalDate dataEntregaPrevista) {
        this.dataEntregaPrevista = dataEntregaPrevista;
    }

    public LocalDate getDataEntregaAluno() {
        return dataEntregaAluno;
    }

    public void setDataEntregaAluno(LocalDate dataEntregaAluno) {
        this.dataEntregaAluno = dataEntregaAluno;
    }

    public void setEstado(EstadoTrabalho estado) {
        this.estado = estado;
    }

    public EstadoTrabalho getEstado() {

        LocalDate hoje = LocalDate.now();

        // se entregou, mantém entregue
        if (estado instanceof EntregueState) {
            return estado;
        }

        // se passou do prazo, vira pendente
        if (
                dataEntregaPrevista != null
                        && hoje.isAfter(dataEntregaPrevista)
        ) {
            return new PendenteState();
        }

        // padrão
        return new AtribuidoState();
    }

    public boolean podeEditar() {
        return getEstado().podeEditar();
    }
    public boolean podeEntregar() {
        return getEstado().podeEntregar();
    }

    public boolean podeExcluir() {
        return getEstado().podeExcluir();
    }

    public String getClasseCor() {
        return getEstado().getClasseCor(this);
    }

    public int getPrioridade() {

        String cor = getClasseCor();

        if (cor == null) return 0;

        switch (cor) {
            case "bg-red": return 3;
            case "bg-yellow": return 2;
            case "bg-gray": return 1;
            default: return 0;
        }
    }

    public String getIdGoogleCalendar() {return idGoogleCalendar;}
    public void setIdGoogleCalendar(String idGoogleCalendar) {this.idGoogleCalendar = idGoogleCalendar;}
}