//atividade
// abrir modal
function abrirModal() {
    const modal = document.getElementById("modal-atividade-container");
    if (modal) {
        modal.style.display = "flex";
    }
}

// fechar modal
function fecharModal() {
    const modal = document.getElementById("modal-atividade-container");
    if (modal) {
        modal.style.display = "none";
    }
}

// excluir atividade
function excluirAtividade(id) {

    let confirmar = confirm("Excluir atividade?");

    if (confirmar) {
        window.location.href = "AtividadeServlet?id=" + id;
    }
}

/*
function entregarAtividade(id) {
        window.location.href = "AtividadeServlet?id=" + id;
    }
}
 */

//card
function toggleMenu() {
    const menu = document.getElementById('menu-opcoes-usuario');
    if (menu) menu.classList.toggle('active');
}

window.alternarDetalhesCard = function(idDoCard) {
    const card = document.getElementById(idDoCard);
    if (card) {
        card.classList.toggle('expanded');
    }
};

window.addEventListener("click", function(event) {

    // fecha modal atividade (clicou no fundo)
    const modalAtividade = document.getElementById("modal-atividade-container");
    if (modalAtividade && event.target === modalAtividade) {
        fecharModal();
    }

    // fecha menu usuário
    const menu = document.getElementById('menu-opcoes-usuario');
    if (
        menu &&
        !event.target.closest('.user-menu') &&
        !event.target.closest('.dropdown')
    ) {
        menu.classList.remove('active');
    }

});