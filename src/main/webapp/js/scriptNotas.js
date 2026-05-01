// modal
//abrir
function abrirModal(modo, id='', nome='', sigla='', creditos=''){
    const modal=document.getElementById('modal-materia-container');
    const titulo=document.getElementById('modal-titulo');

    document.getElementById('materia-id').value=id;
    document.getElementById('materia-nome').value=nome;
    document.getElementById('materia-sigla').value=sigla;
    document.getElementById('materia-creditos').value=creditos;

    if(modo==='editar') titulo.innerText="Editar Matéria";
    else{
        titulo.innerText="Adicionar Matéria";
        document.getElementById('form-materia').reset();
        document.getElementById('materia-id').value='';
    }
    modal.style.display='flex';
}

//fechar
const modal=document.getElementById('modal-materia-container');
function fecharModal(){modal.style.display='none';}
window.addEventListener('click', (event) =>{if(event.target===modal) fecharModal();});

//filtro
// toggle filtro
function toggleMenuFiltro() {
    const menu=document.getElementById('menu-opcoes-filtro');
    menu.style.display=menu.style.display==='flex'?'none':'flex';
}

// pesquisa com filtro
document.addEventListener("DOMContentLoaded", ()=>{
    const input=document.getElementById("input-busca-materia");
    const container=document.getElementById("container-materias-disponiveis");
    const checkboxes=document.querySelectorAll(".check-periodo");

    function pesquisarEOdernar(){
        const termo=input.value.toLowerCase().trim();
        let materias=Array.from(container.querySelectorAll(".linha-materia"));

        // texto
        materias.forEach(linha => {
            const nomeMateria=linha.querySelector(".col-nome").innerText.toLowerCase();
            const siglaMateria=linha.querySelector(".col-sigla").innerText.toLowerCase();
            
            const bateBusca=nomeMateria.includes(termo) || siglaMateria.includes(termo);
            linha.style.display=bateBusca?"flex":"none";
        });

        // ordenacao
        const ativo=Array.from(checkboxes).find(c => c.checked);
        if(ativo){
            materias.sort((a, b)=>{
                switch(ativo.value){
                    case "1": // cred crescente
                        return parseFloat(a.querySelector(".col-creditos").innerText) - parseFloat(b.querySelector(".col-creditos").innerText);
                    case "2": // cred decrescente
                        return parseFloat(b.querySelector(".col-creditos").innerText) - parseFloat(a.querySelector(".col-creditos").innerText);
                    case "3": // az
                        return a.querySelector(".col-nome").innerText.localeCompare(b.querySelector(".col-nome").innerText);
                    case "4": // za
                        return b.querySelector(".col-nome").innerText.localeCompare(a.querySelector(".col-nome").innerText);
                    default:
                        return 0;
                }
            });
            materias.forEach(materia=>container.appendChild(materia));
        }
    }

    input.addEventListener("input", pesquisarEOdernar);
    checkboxes.forEach(c=>{
        c.addEventListener("change", (e)=>{
            if(e.target.checked) checkboxes.forEach(cb=>{if (cb!==e.target) cb.checked=false;});
            pesquisarEOdernar();
        });
    });
});