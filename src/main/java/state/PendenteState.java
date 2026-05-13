package state;

import model.Trabalho;

import java.time.Duration;
import java.time.LocalDateTime;

public class PendenteState
        implements EstadoTrabalho {

    @Override
    public String getNome() {
        return "pendente";
    }

    @Override
    public boolean podeExcluir() {
        return true;
    }

    @Override
    public boolean podeEditar() {
        return true;
    }

    @Override
    public boolean podeEntregar() { return true; }

    @Override
    public String getClasseCor(Trabalho t){
        return "bg-red";
    }

    @Override
    public boolean apareceEmPendentes() {
        return true;
    }
}