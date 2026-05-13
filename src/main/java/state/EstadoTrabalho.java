package state;

import model.Trabalho;

public interface EstadoTrabalho {

    String getNome();

    boolean podeExcluir();

    boolean podeEditar();

    boolean podeEntregar();

    String getClasseCor(
            Trabalho trabalho
    );

    boolean apareceEmPendentes();
}