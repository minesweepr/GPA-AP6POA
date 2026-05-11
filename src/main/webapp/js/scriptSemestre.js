// parâmetro geral exclusão
let idParaExcluir=null;

// toggle modais
function toggleModal(idModal, abrir=true){
    const modal=document.getElementById(idModal);
    if(modal) modal.classList.toggle('visivel', abrir);
}

// abrir Modal de Cadastro/Edição
function abrirModalSemestre(modo, id='', nome=''){
    const form=document.getElementById('form-semestre');
    document.getElementById('modal-titulo').innerText=modo==='editar'?"Editar Semestre":"Adicionar Semestre";

    document.getElementById('semestre-id').value=id;
    document.getElementById('semestre-nome').value=nome;
    if(modo!=='editar') form.reset();

    toggleModal('modal-semestre-container', true);
}

// abrir Modal de Exclusão
function abrirModalExclusao(id, nome){
    idParaExcluir=id;
    document.getElementById('nome-semestre-excluir').innerText=nome;

    fecharDropdowns();
    toggleModal('modal-exclusao-container', true);
}

// dropdown dinâmico
function mostrarMenuSemestre(event, idMenu){
    fecharDropdowns();
    const menu=document.getElementById(idMenu);
    const rect=event.currentTarget.getBoundingClientRect();

    menu.classList.add('visivel');
    menu.style.position='fixed';
    menu.style.top=`${rect.bottom + 5}px`;
    menu.style.right=`${window.innerWidth - rect.right}px`;
    menu.style.left='auto';
}

// limpar a tela
const fecharDropdowns=()=>document.querySelectorAll('.dropdown-semestre').forEach(m=>m.classList.remove('visivel'));

// fechar tudo
window.addEventListener('click', (e)=>{
    if(e.target.classList.contains('modal-overlay')) e.target.classList.remove('visivel');
    if(!e.target.closest('.fa-ellipsis-vertical') && !e.target.closest('.dropdown-semestre'))fecharDropdowns();
});

// excluir
document.getElementById('btn-confirmar-delete').onclick = () => {
    if(idParaExcluir) window.location.href=`SemestreServlet?excluirId=${idParaExcluir}`;
};