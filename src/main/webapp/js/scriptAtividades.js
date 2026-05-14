window.addEventListener("load", () => {

    const containerPrazo =
        document.getElementById(
            "container-lista-disciplinas"
        );

    if (
        !containerPrazo.querySelector(
            ".course-card"
        )
    ) {

        containerPrazo.style.display =
            "block";

        containerPrazo.innerHTML = `
            <div class="sem-prazo">
                Nenhuma atividade pendente
            </div>
        `;
    }

    const listaAtividades =
        document.getElementById(
            "lista-atividades"
        );

    if (
        !listaAtividades.querySelector(
            ".atividade"
        )
    ) {

        listaAtividades.innerHTML = `
            <div class="sem-prazo">
                Nenhuma atividade no filtro atual
            </div>
        `;
    }
});

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

function excluirAtividade(
    id,
    semestreId,
    filtro
) {

    window.location.href =
        "AtividadeServlet?id="
        + id
        + "&semestreId="
        + semestreId
        + "&filtro="
        + filtro;
}

function entregarAtividade(id, semestreId ,filtro){

    window.location.href =
        "MudarStateEntregueServlet?id="
        + id
        + "&semestreId="
        + semestreId
        + "&filtro="
        + filtro;
}

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