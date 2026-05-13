package state;

import model.Trabalho;

import java.time.Duration;
import java.time.LocalDateTime;

public class AtribuidoState implements EstadoTrabalho {

    @Override
    public String getNome() {
        return "atribuida";
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
    public boolean podeEntregar() {
        return true;
    }

    @Override
    public String getClasseCor(Trabalho t) {

        // se não tiver prazo, mantém neutro
        if (t.getDataEntregaPrevista() == null) {
            return "bg-gray";
        }

        long dias = Duration.between(
                LocalDateTime.now(),
                t.getDataEntregaPrevista().atStartOfDay()
        ).toDays();

        // atrasado ou crítico (<= 2 dias)
        if (dias <= 2) {
            return "bg-red";
        }

        // risco médio (3 a 4 dias)
        if (dias <= 4) {
            return "bg-yellow";
        }

        // seguro (> 4 dias)
        return "bg-gray";
    }

    @Override
    public boolean apareceEmPendentes() {
        return true;
    }
}