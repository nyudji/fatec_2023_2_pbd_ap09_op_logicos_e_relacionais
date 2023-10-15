/*Função Bloco de Código 1.1*/
CREATE OR REPLACE FUNCTION valor_aleatorio_entre (lim_inferior INT, lim_superior
INT) RETURNS INT AS
$$
BEGIN
RETURN FLOOR(RANDOM() * (lim_superior - lim_inferior + 1) + lim_inferior)::INT;
END;
$$ LANGUAGE plpgsql;


/*1.1 Faça um programa que exibe se um número inteiro é múltiplo de 3.*/
DO
$$
DECLARE
	numero INT := valor_aleatorio_entre(10,50);
BEGIN
RAISE NOTICE 'Número aleatório : %', numero;

IF numero % 3 = 0 THEN
        RAISE NOTICE '% é múltiplo de 3.', numero;
    ELSE
        RAISE NOTICE '% não é múltiplo de 3.', numero;
    END IF;
END;
$$

/*1.2 Faça um programa que exibe se um número inteiro é múltiplo de 3 ou de 5.*/

CREATE OR REPLACE FUNCTION verifica_multiplo_de_tres_ou_cinco(numero INT) 
RETURNS VOID 
AS 
$$
BEGIN
    IF numero % 3 = 0 AND numero % 5 = 0 THEN
        RAISE NOTICE '% é múltiplo de 3 e de 5.', numero;
    ELSIF numero % 3 = 0 THEN
        RAISE NOTICE '% é múltiplo de 3, mas não de 5.', numero;
    ELSIF numero % 5 = 0 THEN
        RAISE NOTICE '% é múltiplo de 5, mas não de 3.', numero;
    ELSE
        RAISE NOTICE '% não é múltiplo de 3 nem de 5.', numero;
    END IF;
END;
$$ 
LANGUAGE plpgsql;
SELECT verifica_multiplo_de_tres_ou_cinco(20);

/*
1.3 Faça um programa que opera de acordo com o seguinte menu.
Opções:
1 - Soma
2 - Subtração
3 - Multiplicação
4 - Divisão
Cada operação envolve dois números inteiros. O resultado deve ser exibido no formato
op1 op op2 = res
Exemplo:
2 + 3 = 5
*/

CREATE OR REPLACE FUNCTION realizar_operacao(op1 INT, op2 INT, operacao INT) 
RETURNS VOID 
AS 
$$
DECLARE
    resultado INT;
BEGIN
    CASE operacao
        WHEN 1 THEN
            resultado := op1 + op2;
            RAISE NOTICE '% + % = %', op1, op2, resultado;
        WHEN 2 THEN
            resultado := op1 - op2;
            RAISE NOTICE '% - % = %', op1, op2, resultado;
        WHEN 3 THEN
            resultado := op1 * op2;
            RAISE NOTICE '% * % = %', op1, op2, resultado;
        WHEN 4 THEN
            IF op2 = 0 THEN
                RAISE NOTICE 'Divisão por zero não é permitida.';
            ELSE
                resultado := op1 / op2;
                RAISE NOTICE '% / % = %', op1, op2, resultado;
            END IF;
        ELSE
            RAISE NOTICE 'Opção inválida.';
    END CASE;
END;
$$ 
LANGUAGE plpgsql;

SELECT realizar_operacao(2, 3, 1); -- Realiza uma adição (2 + 3)
SELECT realizar_operacao(5, 3, 2); -- Realiza uma subtração (5 - 3)
SELECT realizar_operacao(4, 7, 3); -- Realiza uma multiplicação (4 * 7)
SELECT realizar_operacao(10, 2, 4); -- Realiza uma divisão (10 / 2)
SELECT realizar_operacao(8, 0, 4); -- Tentativa de divisão por zero (exibirá uma mensagem de erro)
SELECT realizar_operacao(3, 5, 5); -- Opção inválida (exibirá uma mensagem de erro)


/*1.4 Um comerciante comprou um produto e quer vendê-lo com um lucro de 45% se o valor
da compra for menor que R$20. Caso contrário, ele deseja lucro de 30%. Faça um
programa que, dado o valor do produto, calcula o valor de venda.*/
CREATE OR REPLACE FUNCTION calcular_preco_venda(valor_compra NUMERIC) 
RETURNS NUMERIC 
AS 
$$
DECLARE
    preco_venda NUMERIC;
BEGIN
    IF valor_compra < 20 THEN
        preco_venda := valor_compra * 1.45; -- Lucro de 45%
        RAISE NOTICE 'O produto foi comprado por R$% e será vendido com lucro de 45%% por R$%.', valor_compra, preco_venda;
    ELSE
        preco_venda := valor_compra * 1.3;  -- Lucro de 30%
        RAISE NOTICE 'O produto foi comprado por R$% e será vendido com lucro de 30%% por R$%.', valor_compra, preco_venda;
    END IF;

    RETURN preco_venda;
END;
$$ 
LANGUAGE plpgsql;
SELECT calcular_preco_venda(15); -- Retorna o preço de venda se o custo for menor que R$20
SELECT calcular_preco_venda(25); -- Retorna o preço de venda se o custo for igual ou maior que R$20


