/*3. O governo do estado também deseja controlar todas as promoções dos funcionários ao longo do anos. Assim como no caso das faltas, 
esse mecanismo não se encontra implementado no banco de dados. É sua responsabilidade implementar esse controle. 
Cada funcionário possui um cargo (que por simplificação pode variar entre CARGO1, CARGO2 e CARGO 3) e seu nível pode variar entre 1 e 7. 
Ou seja, o funcionário pode ter o CARGO1 e Nível 5 no momento, e, na próxima promoção ele terá o CARGO1 (que não muda) e Nível 6, e assim por diante. 
Lembrando que cada funcionário só pode aumentar seu nível de 3 em 3 anos e não pode haver interseção de períodos entre dois níveis. 
Além disso, um funcionário só pode ser promovido para o nível imediatamente superior ao atual, logo uma promoção do Nível 1 para o Nível 3 é proibida. 

Desenvolva uma stored procedure que implemente a promoção de um determinado funcionário. Sua stored procedure deve receber o CPF do funcionário e o nível 
para promoção como parâmetros de entrada.*/

--SGBD SQL SERVER

--Criação da table status para controle de status de funcionário por cargo
CREATE TABLE status
(
	cargo VARCHAR(30),
	nivel INT
	nivelanterior INT
	datapromocao DATE --data da promocao atual
	datapromocaoanterior DATE --data da última promocao recebida
	id INT FOREIGN KEY REFERENCES funcionario(id)
);
--Criação de Stored Procedure para implementar promoção de funcionários
ALTER PROCEDURE ControleDePromocoes
	@cpf VARCHAR(11),
	@nivel INT
AS

BEGIN
	IF ((YEAR(status.datapromocao) - YEAR(status.datapromocaoanterior))<3) AND ((nivel - nivelanterior)=1)
	BEGIN
		UPDATE status
		SET nivel = @nivel
		WHERE funcionario.cpf = @cpf
		
		UPDATE status
		SET datapromocaoanterior = datapromocao
		
		UPDATE status
		SET datapromocao = GETDATE()
	END
END