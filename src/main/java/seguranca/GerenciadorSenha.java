package seguranca;

import org.mindrot.jbcrypt.BCrypt;

public class GerenciadorSenha {
    private static final int logRounds=12;

    public static String criptografar(String senha){
        String salt=BCrypt.gensalt(logRounds);
        return BCrypt.hashpw(senha, salt);
    }

    public static boolean verificar(String senha, String hashBDD){
        // try-catch usado por segurança extra
        try{return BCrypt.checkpw(senha, hashBDD);}
        catch(IllegalArgumentException e){return false;}
    }
}
