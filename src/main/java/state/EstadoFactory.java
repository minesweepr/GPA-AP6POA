package state;

public class EstadoFactory {

    public static EstadoTrabalho
    criar(String situacao){

        if(situacao == null){
            return new AtribuidoState();
        }

        switch(situacao.toLowerCase()){
            case "atribuida":
                return new AtribuidoState();

            case "pendente":
                return new PendenteState();

            case "entregue":
                return new EntregueState();

            default:
                return new AtribuidoState();
        }
    }
}