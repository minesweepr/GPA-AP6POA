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

document.addEventListener("DOMContentLoaded", function () {
    const checkbox = document.getElementById("confirmar-prosseguir");
    const btn = document.getElementById("btn-proximo");

    if (checkbox && btn) {
        checkbox.addEventListener("change", function () {
            btn.disabled = !this.checked;
        });

        btn.addEventListener("click", function () {
            document.getElementById("google-alerta").style.display = "none";
            document.getElementById("form-atividade").style.display = "block";
            localStorage.setItem("google_warning_accepted", "true");
        });
    }
});

function abrirModal(id = null, idAlunoMateria = "", titulo = "", dataPrazo = "") {
    const modal = document.getElementById("modal-atividade-container");
    const form = document.getElementById("form-atividade");

    const googleConectado = window.googleAutenticado === true;

    const alerta = document.getElementById("google-alerta");
    const checkbox = document.getElementById("confirmar-prosseguir");
    const btnProximo = document.getElementById("btn-proximo");

    form.reset();

    const jaAceitou = localStorage.getItem("google_warning_accepted") === "true";

    const atualizando = id !== null;

    form.action = atualizando ? "AtualizarAtividadeServlet" : "AtividadeServlet";

    document.getElementById("modal-titulo").textContent =
        atualizando ? "Atualizar Atividade" : "Adicionar Atividade";

    document.getElementById("atividade-id").value = id || "";
    document.getElementById("atividade-materia").value = idAlunoMateria;
    document.getElementById("atividade-nome").value = titulo;
    document.getElementById("atividade-data").value = dataPrazo;

    if (alerta) alerta.style.display = "none";
    if (form) form.style.display = "none";
    if (checkbox) checkbox.checked = false;
    if (btnProximo) btnProximo.disabled = true;

    if (!googleConectado && !jaAceitou) {
        alerta.style.display = "block";
        form.style.display = "none";
    } else {
        alerta.style.display = "none";
        form.style.display = "block";
    }

    modal.style.display = "flex";
}

function fecharModal() {

    const modalAdicionar =
        document.getElementById(
            "modal-atividade-container"
        );

    const modalAtualizar =
        document.getElementById(
            "modal-atualizar-container"
        );

    if(modalAdicionar){
        modalAdicionar.style.display =
            "none";
    }

    if(modalAtualizar){
        modalAtualizar.style.display =
            "none";
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

function atualizarAtividade(id, semestreId, filtro) {
    window.location.href =
        "AtualizarAtividadeServlet?id="
        + id
        + "&semestreId="
        + semestreId
        + "&filtro="
        + filtro;
}

function entregarAtividade(id, semestreId ,filtro){
    window.location.href =
        "AtualizarAtividadeServlet?id="
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