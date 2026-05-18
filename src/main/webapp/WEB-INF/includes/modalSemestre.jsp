<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="modal-overlay" id="modal-semestre-container">
    <div class="modal-content">
        <div id="modal-titulo" class="modal-header">Adicionar Semestre</div>
        <div class="modal-body">
            <form id="form-semestre" action="<%= request.getContextPath() %>/SemestreServlet" method="POST">
                <input type="hidden" id="semestre-id" name="idSemestre">

                <div class="input-group">
                    <label>Semestre</label>
                    <input type="text" autocomplete="off" id="semestre-nome" name="nome" placeholder="Ex: 2020.1, 2020.2..." required>
                </div>
                <div class="modal-actions">
                    <button type="button" class="btn-basico secundario" onclick="toggleModal('modal-semestre-container', false)">CANCELAR</button>
                    <button type="submit" class="btn-basico">CONFIRMAR</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal-overlay" id="modal-exclusao-container">
    <div class="modal-content">
        <div class="modal-header">Confirmar Exclusão</div>
        <div class="modal-body">
            <p>Tem certeza que deseja excluir o semestre <strong id="nome-semestre-excluir"></strong>?</p>
            <p>Esta ação não pode ser desfeita.</p>

            <div class="modal-actions">
                <button id="modal-fechar-exclusao" type="button" class="btn-basico secundario" onclick="toggleModal('modal-exclusao-container', false)">CANCELAR</button>
                <button id="btn-confirmar-delete" type="submit" class="btn-basico vermelho">EXCLUIR</button>
            </div>
        </div>
    </div>
</div>