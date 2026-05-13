package state;

import model.Trabalho;

public class EntregueState
        implements EstadoTrabalho {

    @Override
    public String getNome() {
        return "entregue";
    }

    @Override
    public boolean podeExcluir() {
        return false;
    }

    @Override
    public boolean podeEditar() {
        return false;
    }

    @Override
    public boolean podeEntregar() {
        return true;
    }

    @Override
    public String getClasseCor(
            Trabalho trabalho
    ){
        return "bg-green";
    }

    @Override
    public boolean apareceEmPendentes() {
        return false;
    }
}