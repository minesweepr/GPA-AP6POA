package model;

import state.*;

import java.time.Clock;
import java.time.LocalDate;

public class Trabalho {

    private int idTrabalho;
    private int idAlunoMateria;

    private String titulo;

    private LocalDate dataEntregaPrevista;
    private LocalDate dataEntregaAluno;

    private EstadoTrabalho estado;
    private static final EstadoTrabalho ATRIBUIDO = new AtribuidoState();
    private static final EstadoTrabalho PENDENTE = new PendenteState();

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

        // se for entregue nao faz a troca de estado
        if (estado != null &&
                (estado instanceof EntregueState ||
                        "entregue".equalsIgnoreCase(estado.getNome()))) {
            return estado;
        }

        Clock clock = Clock.systemDefaultZone();
        LocalDate hoje = LocalDate.now(clock);

        // sem data tem o padrao de atribuído
        if (dataEntregaPrevista == null) {
            return ATRIBUIDO;
        }

        // passar do prazo vira pendente
        if (hoje.isAfter(dataEntregaPrevista)) {
            return PENDENTE;
        }

        return ATRIBUIDO;
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
}