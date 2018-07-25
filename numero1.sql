/*1. Elabore uma stored procedure para diminuir o salário de um funcionário em um determinado percentual. 
A sua procedure deve se chamar DiminuirSalario e deve receber como parâmetros de entrada o CPF do funcionário e um valor inteiro que representa 
o percentual de redução.*/ 

--SGBD SQL SERVER

ALTER PROCEDURE DiminuirSalario 
	@cpf VARCHAR(11), 
	@percentual INT
AS

BEGIN
	UPDATE funcionario SET salario = salario-(salario*@percentual/100)
	WHERE cpf = @cpf
END
