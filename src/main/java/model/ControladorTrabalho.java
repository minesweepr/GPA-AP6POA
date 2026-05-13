package model;

import model.Trabalho;

import java.time.Duration;
import java.time.LocalDate;

public class ControladorTrabalho {

    public String getTempoRestante(Trabalho t) {

        LocalDate hoje = LocalDate.now();
        LocalDate prazo = t.getDataEntregaPrevista();

        if (prazo == null) {
            return "Sem prazo definido";
        }

        long dias = Duration.between(
                hoje.atStartOfDay(),
                prazo.atStartOfDay()
        ).toDays();

        if (dias < 0) {
            return "Prazo encerrado";
        }

        return dias + " dias restantes";
    }

    public double getPercentualPrazo(Trabalho t) {

        LocalDate hoje = LocalDate.now();
        LocalDate prazo = t.getDataEntregaPrevista();

        if (prazo == null) return 0;

        long total = Duration.between(
                hoje.minusDays(7).atStartOfDay(),
                prazo.atStartOfDay()
        ).toMinutes();

        long restante = Duration.between(
                hoje.atStartOfDay(),
                prazo.atStartOfDay()
        ).toMinutes();

        if (total <= 0) return 0;

        double valor = (restante * 1.0) / total;

        if (valor < 0) valor = 0;
        if (valor > 1) valor = 1;

        return valor;
    }


}