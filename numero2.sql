/*2. Além da redução de salários, o governo prevê demissões para funcionários que faltem sem justificativa apresentada. 
Esse tipo de controle não existe hoje no banco de dados. Sua tarefa é desenvolver um mecanismo que controle as faltas de cada um dos funcionários. 
A partir da 5a (quinta) falta sem justificativa o campo ATIVO da tabela funcionário deve ser setado para 'N" significando que ele foi demitido. 

Sugestão: criem uma tabela que controle as faltas e justificativas e uma trigger associada a essa tabela para verificar a quantidade de faltas.*/

--SGBD SQL SERVER

--Criação da table faltas, para controle
CREATE TABLE faltas
(
	qtdfaltas INT,
	justificativa VARCHAR(140)
	id INT FOREIGN KEY REFERENCES funcionario(id)
);
--Criação da trigger para incremento de faltas após cada inserção na table
CREATE TRIGGER TFaltas
ON faltas
AFTER INSERT
AS
	UPDATE faltas
	SET qtdfaltas = qtdfaltas+1;
GO
--Criação de Stored Procedure para validação de faltas e alteração (caso necessário) do campo "ativo" da table funcionario
ALTER PROCEDURE ControleDeFaltas
	@cpf VARCHAR(11)
AS

BEGIN
	IF (faltas.qtdfaltas > 5)
	BEGIN
		UPDATE funcionario SET ativo = 'N'
		WHERE cpf = @cpf
	END
END