programa //Aplicativo de banco
{
	inclua biblioteca Util --> u
	inclua biblioteca Tipos --> tip
	inclua biblioteca Arquivos --> a
	inclua biblioteca Texto --> tx
	
	cadeia nome, sobrenome, idade, cpf, operadora, celular, login, senha, agencia, conta, saldoTx
	inteiro opcao, idadeI, entrar
	real transferir, valor, saldo
	
	funcao inicio()
	{
		menuLogin()
	}
	
	funcao escrevaLinha(logico forte, inteiro linhas)//Escreve uma linha de acordo com as medidas
	{
		se(forte){
			para(inteiro i=1; i<=linhas; i++){
			escreva("=")
			}
			escreva("\n")
		}senao{
			para(inteiro i=1; i<=linhas; i++){
			escreva("-")
			}
			escreva("\n")
		}
	}
	
	funcao menuInicial()//Menu conta usuário
	{
		saldo = obterSaldo()
		escrevaLinha(verdadeiro, 24)
		escreva("  Bem vindo a TechBank\n")
		escrevaLinha(falso, 24)
		escreva(" Saldo atual: R$"+saldo+"\n")
		escrevaLinha(falso, 24)
		escreva("         MENU\n")
		escrevaLinha(falso, 24)
		escreva("1. Transferência\n2. Pagamento\n3. Recarga\n4. Ajuda\n5. Sair\n")
		escrevaLinha(verdadeiro, 24)
		escreva("Digite: ")
		leia(opcao)
		limpa()
		escolha(opcao){
			caso 1: //Transferência
				transferencia()
			pare
			caso 2: //Pagamento
				pagamento()
			pare
			caso 3: //Recarga
				recarga()
			pare
			caso 4: //Suporte
				suporte()
			pare
			caso 5: //Sair
				sair(2)
			pare
			caso contrario: 
				escrevaLinha(verdadeiro, 29)
				escreva(" Selecione uma opção válida!\n")
				escrevaLinha(verdadeiro, 29)
				u.aguarde(1250)
				limpa()
				menuInicial()
			}
	}
	
	funcao menuLogin()//Menu de seleção para Login ou Registro
	{
		escrevaLinha(verdadeiro, 24)
		escreva("         MENU \n")
		escrevaLinha(falso, 24)
		escreva("1. Login\n2. Cadastro\n3. Sair\n")
		escrevaLinha(verdadeiro, 24)
		escreva("Digite: ")
		leia(entrar)
		limpa()
		escolha(entrar){ //Menu Login e Registro
			caso 1: //Login
				Login()
			pare
			caso 2: //Cadastro
				Cadastro()
			pare
			caso 3: //Sair
				sair(1)
			pare
			caso contrario: //Opção inválida 
				escrevaLinha(verdadeiro, 29)
				escreva(" Selecione uma opção válida!\n")
				escrevaLinha(verdadeiro, 29)
				u.aguarde(1250)
				limpa()
				inicio()
		}
	}

	funcao Login()//Acessar conta
	{
		escrevaLinha(verdadeiro, 24)
		escreva("         LOGIN\n")
		escrevaLinha(falso, 24)
		escreva("     Deseja voltar?\n   1. Sim      2. Não\n")
		escrevaLinha(verdadeiro, 24)
		escreva("Digite: ")
		leia(opcao)
		limpa()
		se(opcao==1){
			inicio()
		}senao se(opcao==2){
			escrevaLinha(verdadeiro, 24)
			escreva("         LOGIN\n")
			escrevaLinha(falso, 24)
			escreva("    Digite a agencia\n")
			escrevaLinha(verdadeiro, 24)
			escreva("Digite: ")
			leia(login)
			limpa()
			escrevaLinha(verdadeiro, 24)
			escreva("         LOGIN\n")
			escrevaLinha(falso, 24)
			escreva("    Digite sua conta\n")
			escrevaLinha(verdadeiro, 24)
			escreva("Digite: ")
			leia(senha)
			limpa()
			se(entrarConta()==-1){
				menuInicial()
			}senao se(entrarConta()==0){
				escrevaLinha(verdadeiro, 28)
				escreva(" Agência ou conta inválida!\n")
				escrevaLinha(verdadeiro, 28)
				u.aguarde(1750)
				limpa()
				inicio()
			}
		}senao{
			escrevaLinha(verdadeiro, 29)
			escreva(" Selecione uma opção válida!\n")
			escrevaLinha(verdadeiro, 29)
			u.aguarde(1750)
			limpa()
			inicio()
		}
	}

	funcao inteiro entrarConta()//Verifica se o Login e Senha são válidos
	{
		inteiro check = 0, l = 0
		cadeia diretorio = u.obter_diretorio_usuario() + "/Desktop/Banco/"
		cadeia logins = diretorio + "Agencia.txt"
		logico existe = a.arquivo_existe(logins)
		se(nao existe){
			retorne check
		}
		inteiro ler = a.abrir_arquivo(logins, a.MODO_LEITURA)
		enquanto(nao a.fim_arquivo(ler)){
			cadeia verificarLogin = a.ler_linha(ler)
			l += 1
			inteiro c=l
			se(verificarLogin==login){
				cadeia senhas = diretorio + "Conta.txt"
				inteiro ver = a.abrir_arquivo(senhas, a.MODO_LEITURA)
				logico igual
				faca{
					cadeia verificar = a.ler_linha(ver)
					se(verificar == senha){
						igual = verdadeiro
					}senao{
						igual = falso
					}
					c -= 1
				}enquanto(c>0)
				se(igual){
					a.fechar_arquivo(ler)
					a.fechar_arquivo(ver)
					retorne check = -1
				}
				a.fechar_arquivo(ver)
			}senao{
				check = 0
			}
		}
		a.fechar_arquivo(ler)
		retorne check
	}

	funcao inteiro identificarConta(inteiro &usuario)//Identifica qual Conta foi acessada
	{
		inteiro check = 0, l = 0
		cadeia diretorio = u.obter_diretorio_usuario() + "/Desktop/Banco/"
		cadeia logins = diretorio + "Agencia.txt"
		inteiro ler = a.abrir_arquivo(logins, a.MODO_LEITURA)
		enquanto(nao a.fim_arquivo(ler)){
			cadeia verificarLogin = a.ler_linha(ler)
			l += 1
			inteiro c = l
			se(verificarLogin==login){
				cadeia senhas = diretorio + "Conta.txt"
				inteiro ver = a.abrir_arquivo(senhas, a.MODO_LEITURA)
				logico igual
				faca{
					cadeia verificar = a.ler_linha(ver)
					se(verificar == senha){
						igual = verdadeiro
					}senao{
						igual = falso
					}
					c -= 1
				}enquanto(c>0)
				se(igual){
					a.fechar_arquivo(ver)
					a.fechar_arquivo(ler)
					retorne usuario = l
				}
				a.fechar_arquivo(ver)
			}
		}
		a.fechar_arquivo(ler)
		retorne usuario = 0
	}

	funcao gerarSaldo(cadeia agenciaT, cadeia contaT)//Local onde está o saldo inicial
	{
		inteiro check = 0, l = 0, usuario = -1
		cadeia diretorio = u.obter_diretorio_usuario() + "/Desktop/Banco/"
		cadeia logins = diretorio + "Agencia.txt"
		inteiro ler = a.abrir_arquivo(logins, a.MODO_LEITURA)
		faca{
			cadeia verificarLogin = a.ler_linha(ler)
			l += 1
			inteiro c = l
			se(verificarLogin==agenciaT){
				cadeia senhas = diretorio + "Conta.txt"
				inteiro ver = a.abrir_arquivo(senhas, a.MODO_LEITURA)
				logico igual
				faca{
					cadeia verificar = a.ler_linha(ver)
					se(verificar == contaT)
					{
						igual = verdadeiro
					}senao{
						igual = falso
					}
					c -= 1
				}enquanto(c>0)
				se(igual){
					usuario = l 
				}
				a.fechar_arquivo(ver)
			}
		}enquanto(nao a.fim_arquivo(ler))
		a.fechar_arquivo(ler)
		saldo = 10000.00
		saldoTx = tip.real_para_cadeia(saldo)
		saldoTx = usuario + "," + saldoTx
		
		cadeia saldos = diretorio + "Saldo.txt"
		inteiro adicionarSaldo = a.abrir_arquivo(saldos, a.MODO_ACRESCENTAR)
		a.escrever_linha(saldoTx, adicionarSaldo)
		a.fechar_arquivo(adicionarSaldo)
	}

	funcao real obterSaldo()//Obtem o saldo do usuário logado
	{
		inteiro valorS, nCar
		cadeia saldoT, local
		real grana = 0.0

		inteiro usuario=-1
		identificarConta(usuario)
		
		cadeia diretorio = u.obter_diretorio_usuario() + "/Desktop/Banco/"
		cadeia saldos = diretorio + "Saldo.txt"
		inteiro saldoL = a.abrir_arquivo(saldos, a.MODO_LEITURA)

		para(inteiro i=0; i<=usuario+1; i++){
			cadeia nUsuario = a.ler_linha(saldoL)
			inteiro pV = tx.posicao_texto(",", nUsuario, 0)
			nCar = tx.numero_caracteres(nUsuario)
			cadeia nC = tx.extrair_subtexto(nUsuario, 0, pV)
			inteiro n = tip.cadeia_para_inteiro(nC, 10)
			
			se(n==usuario){
				local = nUsuario
				valorS = tx.posicao_texto(",", local, 0)

				nCar = tx.numero_caracteres(local)
		
				saldoT = tx.extrair_subtexto(local, valorS+1, nCar)
				grana = tip.cadeia_para_real(saldoT)
				a.fechar_arquivo(saldoL)
				retorne grana
			}
		}
		a.fechar_arquivo(saldoL)
		retorne grana
	}
	
	funcao extrairSaldo(real localT, real quantia)//Subtrair o saldo do usuário
	{
		inteiro fimArquivo = 0, i=0
		cadeia saldoT, local, vSaldo[1000]
		
		inteiro usuario=-1
		identificarConta(usuario)

		cadeia diretorio = u.obter_diretorio_usuario()+"/Desktop/Banco/"
		cadeia saldos = diretorio + "Saldo.txt"
		inteiro saldoL = a.abrir_arquivo(saldos, a.MODO_LEITURA)

		enquanto(nao a.fim_arquivo(saldoL)){
			vSaldo[i] = a.ler_linha(saldoL)
			i += 1
			fimArquivo += 1
		}
		a.fechar_arquivo(saldoL)

		localT -= quantia
		local = tip.real_para_cadeia(localT)

		vSaldo[usuario-1] = usuario + "," + local
		saldoL = a.abrir_arquivo(saldos, a.MODO_ESCRITA)
		cadeia linha1 = vSaldo[0]
		a.escrever_linha(linha1, saldoL)
		a.fechar_arquivo(saldoL)
				
		saldoL = a.abrir_arquivo(saldos, a.MODO_ACRESCENTAR)
		
		para(i=0; i<fimArquivo-1; i++){
			cadeia linha = vSaldo[i+1]
			a.escrever_linha(linha, saldoL)
		}
		a.fechar_arquivo(saldoL)
	}

	funcao Cadastro()//Abrir conta
	{
		escrevaLinha(verdadeiro, 24)
		escreva("        CADASTRO\n")
		escrevaLinha(falso, 24)
		escreva("     Deseja voltar? \n   1. Sim      2. Não\n")
		escrevaLinha(verdadeiro, 24)
		escreva("Digite: ")
		leia(opcao)
		limpa()
		se(opcao==1){
			inicio()
		}senao se(opcao!=1 e opcao!=2){
			escrevaLinha(verdadeiro, 29)
			escreva(" Selecione uma opção válida!\n")
			escrevaLinha(verdadeiro, 29)
			u.aguarde(1750)
			limpa()
			inicio()
		}
		escrevaLinha(verdadeiro, 24)
		escreva("        CADASTRO\n")
		escrevaLinha(falso, 24)
		escreva("    Digite seu nome\n")
		escrevaLinha(verdadeiro, 24)
		escreva("Digite: ")
		leia(nome)
		limpa()
		escrevaLinha(verdadeiro, 24)
		escreva("        CADASTRO\n")
		escrevaLinha(falso, 24)
		escreva("  Digite seu sobrenome\n")
		escrevaLinha(verdadeiro, 24)
		escreva("Digite: ")
		leia(sobrenome)
		limpa()
		escrevaLinha(verdadeiro, 24)
		escreva("        CADASTRO\n")
		escrevaLinha(falso, 24)
		escreva("    Digite sua idade\n")
		escrevaLinha(verdadeiro, 24)
		escreva("Digite: ")
		leia(idadeI)
		limpa()
		idade = tip.inteiro_para_cadeia(idadeI, 10)
		escrevaLinha(verdadeiro, 24)
		escreva("        CADASTRO\n")
		escrevaLinha(falso, 24)
		escreva("     Digite seu cpf\n")
		escrevaLinha(verdadeiro, 24)
		escreva("Digite: ")
		leia(cpf)
		limpa()
		gerarConta()
		escrevaLinha(verdadeiro, 33)
		escreva(" Cadastro concluido com sucesso!\n")
		escrevaLinha(verdadeiro, 33)
		u.aguarde(1750)
		limpa()
		inicio()
	}
	
	funcao gerarConta()//Gerar número da conta
	{
		escrevaLinha(verdadeiro, 24)
		escreva("        CADASTRO\n")
		escrevaLinha(falso, 24)
		escreva("    Gerando a conta\n")
		escrevaLinha(falso, 24)
		escreva("        Aguarde!\n")
		escrevaLinha(verdadeiro, 24)
		u.aguarde(1750)
		limpa()
		escrevaLinha(verdadeiro, 24)
		escreva("        CADASTRO\n")
		escrevaLinha(falso, 24)
		escreva("     Agência: ")
		inteiro n1 = u.sorteia(0,9), n2 = u.sorteia(0,9), n3 = u.sorteia(0,9), n4 = u.sorteia(0,9)
		cadeia n1t = tip.inteiro_para_cadeia(n1, 10), n2t = tip.inteiro_para_cadeia(n2, 10), n3t = tip.inteiro_para_cadeia(n3, 10), n4t = tip.inteiro_para_cadeia(n4, 10)
		agencia = n1t + n2t + n3t + n4t
		escreva(agencia)
		escreva("\n     Conta:  ")
		inteiro n5 = u.sorteia(0,9), n6 = u.sorteia(0,9), n7 = u.sorteia(0,9), n8 = u.sorteia(0,9), n9 = u.sorteia(0, 9)
		cadeia n5t = tip.inteiro_para_cadeia(n5, 10), n6t = tip.inteiro_para_cadeia(n6, 10), n7t = tip.inteiro_para_cadeia(n7, 10), n8t = tip.inteiro_para_cadeia(n8, 10), n9t = tip.inteiro_para_cadeia(n9, 10)
		conta = n5t + n6t + n7t + n8t + n9t
		escreva(conta)
		escreva("\n")
		escrevaLinha(falso, 24)
		escreva(" Enter para continuar!\n")
		escrevaLinha(verdadeiro, 24)
		salvarConta()
		gerarSaldo(agencia, conta)
		cadeia p
		leia(p)
		limpa()
	}

	funcao salvarConta()//Cria uma pasta no Desktop com os dados, login e senha
	{
		cadeia banco = u.obter_diretorio_usuario()+"/Desktop/Banco/"
		
		cadeia dados = banco + "Dados.txt"
		inteiro escrever = a.abrir_arquivo(dados, a.MODO_ACRESCENTAR)
		cadeia informacoes = nome + ", " + sobrenome + ", " + idade + ", " + cpf
		a.escrever_linha(informacoes, escrever)
		a.fechar_arquivo(escrever)

		cadeia agencias = banco + "Agencia.txt"
		inteiro adicionarAgencia = a.abrir_arquivo(agencias, a.MODO_ACRESCENTAR)
		a.escrever_linha(agencia, adicionarAgencia)
		a.fechar_arquivo(adicionarAgencia)

		cadeia contas = banco + "Conta.txt"
		inteiro adicionarConta = a.abrir_arquivo(contas, a.MODO_ACRESCENTAR)
		a.escrever_linha(conta, adicionarConta)
		a.fechar_arquivo(adicionarConta)
	}

	funcao inteiro verificarAgencia(cadeia dest)//Verifica se a agência existe
	{
		inteiro check = 0, l = 0, usuario
		cadeia diretorio = u.obter_diretorio_usuario() + "/Desktop/Banco/"
		cadeia logins = diretorio + "Agencia.txt"
		inteiro ler = a.abrir_arquivo(logins, a.MODO_LEITURA)
		enquanto(nao a.fim_arquivo(ler)){
			cadeia verificarLogin = a.ler_linha(ler)
			l += 1
			inteiro c = l
			se(verificarLogin==dest){
				a.fechar_arquivo(ler)
				retorne usuario = l
			}
		}
		a.fechar_arquivo(ler)
		retorne usuario = 0
	}

	funcao real obterDest(inteiro dest)//Obtem saldo do destinatário
	{
		inteiro valorS, nCar
		cadeia saldoT, local
		real grana = 0.0
		
		cadeia diretorio = u.obter_diretorio_usuario() + "/Desktop/Banco/"
		cadeia saldos = diretorio + "Saldo.txt"
		inteiro saldoL = a.abrir_arquivo(saldos, a.MODO_LEITURA)

		para(inteiro i=0; i<=dest+1; i++){
			cadeia nUsuario = a.ler_linha(saldoL)
			inteiro pV = tx.posicao_texto(",", nUsuario, 0)
			nCar = tx.numero_caracteres(nUsuario)
			cadeia nC = tx.extrair_subtexto(nUsuario, 0, pV)
			inteiro n = tip.cadeia_para_inteiro(nC, 10)
			
			se(n==dest){
				local = nUsuario
				valorS = tx.posicao_texto(",", local, 0)

				nCar = tx.numero_caracteres(local)
		
				saldoT = tx.extrair_subtexto(local, valorS+1, nCar)
				grana = tip.cadeia_para_real(saldoT)
				a.fechar_arquivo(saldoL)
				retorne grana
			}
		}
		a.fechar_arquivo(saldoL)
		retorne grana
	}

	funcao transferirSaldo(inteiro dest, real quantia)//Executa a transferenia de saldo para o destinatário
	{
		inteiro fimArquivo = 0, i=0
		cadeia saldoT, local, vSaldo[1000]

		real localT = obterDest(dest)

		inteiro usuario=-1
		identificarConta(usuario)

		cadeia diretorio = u.obter_diretorio_usuario()+"/Desktop/Banco/"
		cadeia saldos = diretorio + "Saldo.txt"
		inteiro saldoL = a.abrir_arquivo(saldos, a.MODO_LEITURA)

		enquanto(nao a.fim_arquivo(saldoL)){
			vSaldo[i] = a.ler_linha(saldoL)
			i += 1
			fimArquivo += 1
		}
		a.fechar_arquivo(saldoL)

		saldo -= quantia
		cadeia saldoTxt = tip.real_para_cadeia(saldo)
		vSaldo[usuario-1] = usuario + "," + saldoTxt

		localT += quantia
		local = tip.real_para_cadeia(localT)

		vSaldo[dest-1] = dest + "," + local
		saldoL = a.abrir_arquivo(saldos, a.MODO_ESCRITA)
		cadeia linha1 = vSaldo[0]
		a.escrever_linha(linha1, saldoL)
		a.fechar_arquivo(saldoL)
		
		saldoL = a.abrir_arquivo(saldos, a.MODO_ACRESCENTAR)
		
		para(i=0; i<fimArquivo-1; i++){
			cadeia linha = vSaldo[i+1]
			a.escrever_linha(linha, saldoL)
		}
		a.fechar_arquivo(saldoL)
	}
	
	funcao transferencia()//Transferir dinheiro de conta
	{
		escrevaLinha(verdadeiro, 34)
		escreva(" Digite a agencia do destinatário\n")
		escrevaLinha(verdadeiro, 34)
		escreva("Digite: ")
		leia(agencia)
		limpa()
		inteiro p = verificarAgencia(agencia)
		se(p == 0){
			escrevaLinha(verdadeiro, 19)
			escreva(" Digite uma agencia válida!")
			escrevaLinha(verdadeiro, 19)
			u.aguarde(1250)
			limpa()
			menuInicial()
		}
		escrevaLinha(verdadeiro, 33)
		escreva(" Digite o valor da transferência\n")
		escrevaLinha(verdadeiro, 33)
		escreva("Digite: ")
		leia(transferir)
		limpa()
		transferirSaldo(p, transferir)
		escrevaLinha(verdadeiro, 37)
		escreva(" Transferência efetuada com sucesso!\n")
		escrevaLinha(verdadeiro, 37)
		u.aguarde(1250)
		limpa()
		menuInicial()
	}

	funcao pagamento()//Pagar boletos
	{
		inteiro n, n1, n2, n3
		n1 = u.sorteia(30, 500)
		n2 = u.sorteia(30, 500)
		n3 = u.sorteia(25, 100)
		escrevaLinha(verdadeiro, 34)
		escreva(" Escolha a conta que deseja pagar\n")
		escrevaLinha(falso, 34)
		escreva(" 1. Luz\n 2. Água\n 3. Internet\n 4. Voltar\n")
		escrevaLinha(verdadeiro, 34)
		escreva("digite: ")
		leia(n)
		limpa()
		escolha(n){
			caso 1: //Conta de Luz
				escrevaLinha(verdadeiro, 27)
				escreva("   Valor da conta R$", n1, "\n")
				escrevaLinha(falso, 27)
				escreva(" Deseja efetuar pagamento?\n    1. Sim      2. Não\n")
				escrevaLinha(verdadeiro, 27)
				escreva("Digite: ")
				leia(entrar)
				limpa()
				se(entrar == 1){
					real local = saldo
					extrairSaldo(local, n1)
					saldo = local
					escrevaLinha(verdadeiro, 37)
					escreva("   Pagamento efetuado com sucesso!\n")
					escrevaLinha(verdadeiro, 37)
					u.aguarde(1250)
					limpa()
					pagamento()
				}senao se(entrar ==2){
					pagamento()
				}senao{
					escrevaLinha(verdadeiro, 24)
					escreva("    Opção inválida!\n")
					escrevaLinha(verdadeiro, 24)
					u.aguarde(1250)
					limpa()
					pagamento()
				}
			pare
			caso 2: //Conta de Água
				escrevaLinha(verdadeiro, 27)
				escreva("   Valor da conta R$", n2, "\n")
				escrevaLinha(falso, 27)
				escreva(" Deseja efetuar pagamento?\n    1. Sim      2. Não\n")
				escrevaLinha(verdadeiro, 27)
				escreva("Digite: ")
				leia(entrar)
				limpa()
				se(entrar == 1){
					real local = saldo
					extrairSaldo( local, n2)
					saldo = local
					escrevaLinha(verdadeiro, 37)
					escreva("   Pagamento efetuado com sucesso!\n")
					escrevaLinha(verdadeiro, 37)
					u.aguarde(1250)
					limpa()
					pagamento()
				}senao se(entrar ==2){
					pagamento()
				}senao{
					escrevaLinha(verdadeiro, 24)
					escreva("    Opção inválida!\n")
					escrevaLinha(verdadeiro, 24)
					u.aguarde(1250)
					limpa()
					pagamento()
				}
			pare
			caso 3: //Conta de Internet
				escrevaLinha(verdadeiro, 27)
				escreva("   Valor da conta R$", n3, "\n")
				escrevaLinha(falso, 27)
				escreva(" Deseja efetuar pagamento?\n    1. Sim      2. Não\n")
				escrevaLinha(verdadeiro, 27)
				escreva("Digite: ")
				leia(entrar)
				limpa()
				se(entrar == 1){
					real local = saldo
					extrairSaldo( local, n3)
					saldo = local
					escrevaLinha(verdadeiro, 37)
					escreva("   Pagamento efetuado com sucesso!\n")
					escrevaLinha(verdadeiro, 37)
					u.aguarde(1250)
					limpa()
					pagamento()
				}senao se(entrar ==2){
					pagamento()
				}senao{
					escrevaLinha(verdadeiro, 24)
					escreva("    Opção inválida!\n")
					escrevaLinha(verdadeiro, 24)
					u.aguarde(1250)
					limpa()
					pagamento()
				}
			pare
			caso 4: //Voltar
				escrevaLinha(verdadeiro, 24)
				escreva("   Você tem certeza?\n   1. Sim   2. Não\n")
				escrevaLinha(verdadeiro, 24)
				escreva("Digite: ")
				leia(opcao)
				limpa()
				se(opcao == 2){
					pagamento()
				}senao se(opcao == 1){
					menuInicial()
				}senao{
					escrevaLinha(verdadeiro, 24)
					escreva("    Opção inválida!\n")
					escrevaLinha(verdadeiro, 24)
					u.aguarde(1250)
					limpa()
					pagamento()
				}
			pare
			caso contrario: //Seleção inválida
				escrevaLinha(verdadeiro, 29)
				escreva(" Selecione uma opção válida!\n")
				escrevaLinha(verdadeiro, 29)
				u.aguarde(1250)
				limpa()
				pagamento()
		}
	}

	funcao recarga()//Recarregar crédito celular
	{
		escrevaLinha(verdadeiro, 35)
		escreva(" Digite a operadora do dispositivo\n")
		escrevaLinha(verdadeiro, 35)
		escreva("Digite: ")
		leia(operadora)
		limpa()
		escrevaLinha(verdadeiro, 32)
		escreva(" Digite o número do dispositivo\n")
		escrevaLinha(verdadeiro, 32)
		escreva("Digite: ")
		leia(celular)
		limpa()
		escrevaLinha(verdadeiro, 27)
		escreva(" Digite o valor da recarga\n")
		escrevaLinha(verdadeiro, 27)
		escreva("Digite: ")
		leia(valor)
		limpa()
		real local = saldo
		extrairSaldo( local, valor)
		saldo = local
		escrevaLinha(verdadeiro, 31)
		escreva(" Recarga efetuada com sucesso!\n")
		escrevaLinha(verdadeiro, 31)
		u.aguarde(1250)
		limpa()
		menuInicial()
	}

	funcao suporte()//Ajuda ao usuário
	{
		escrevaLinha(verdadeiro, 24)
		escreva("         AJUDA\n")
		escrevaLinha(falso, 24)
		escreva("1. Transferência\n2. Pagamento\n3. Recarga\n4. voltar\n")
		escrevaLinha(verdadeiro, 24)
		escreva("Digite: ")
		leia(opcao)
		limpa()
		escolha(opcao){
			caso 1://Ajuda em Transferencia
				escrevaLinha(verdadeiro, 38)
				escreva("        AJUDA -- TRANSFERENCIA\n")
				escrevaLinha(falso, 38)
				escreva(" No menu pressione 1, após isso,\n Digite a agência do destinatário, e,\n Em seguida o valor da transferencia!\n")
				escrevaLinha(falso, 38)
				escreva("         Enter para retornar!\n")
				escrevaLinha(verdadeiro, 38)
				cadeia h
				leia(h)
				limpa()
				suporte()
			pare
			caso 2://Ajuda em Pagamento
				escrevaLinha(verdadeiro, 38)
				escreva("          AJUDA -- PAGAMENTO\n")
				escrevaLinha(falso, 38)
				escreva(" No menu pressione 2, após isso,\n Selecione o boleto que deseja pagar\n E em seguida confirme o pagamento!\n")
				escrevaLinha(falso, 38)
				escreva("         Enter para retornar!\n")
				escrevaLinha(verdadeiro, 38)
				cadeia y
				leia(y)
				limpa()
				suporte()
			pare
			caso 3://Ajuda em Recarga
				escrevaLinha(verdadeiro, 38)
				escreva("          AJUDA -- PAGAMENTO\n")
				escrevaLinha(falso, 38)
				escreva(" No menu pressione 3, após isso,\n Informe a operadora do dispositivo,\n O número do seu dispositivo móvel\n E o valor que será efetuado recarga!\n")
				escrevaLinha(falso, 38)
				escreva("         Enter para retornar!\n")
				escrevaLinha(verdadeiro, 38)
				cadeia f
				leia(f)
				limpa()
				suporte()
			pare
			caso 4://Voltar
				escrevaLinha(verdadeiro, 24)
				escreva("   Você tem certeza?\n   1. Sim   2. Não\n")
				escrevaLinha(verdadeiro, 24)
				escreva("Digite: ")
				leia(opcao)
				limpa()
				se(opcao == 2){
					suporte()
				}senao se(opcao == 1){
					menuInicial()
				}senao{
					escrevaLinha(verdadeiro, 24)
					escreva("    Opção inválida!\n")
					escrevaLinha(verdadeiro, 24)
					u.aguarde(1250)
					limpa()
					suporte()
				}
			pare
			caso contrario:
				escrevaLinha(verdadeiro, 29)
				escreva(" Selecione uma opção válida!\n")
				escrevaLinha(verdadeiro, 29)
				u.aguarde(1250)
				limpa()
				suporte()
		}
	}

	funcao sair(inteiro tela)//Encerrar programa
	{
		escrevaLinha(verdadeiro, 24)
		escreva("   Você tem certeza?\n   1. Sim   2. Não\n")
		escrevaLinha(verdadeiro, 24)
		escreva("Digite: ")
		leia(opcao)
		limpa()
		se(tela == 1){
			se(opcao == 2){
				inicio()
			}senao se(opcao == 1){
				escrevaLinha(verdadeiro, 24)
				escreva("  Programa Finalizado!\n")
				escrevaLinha(verdadeiro, 24)
				u.aguarde(1000)
			}senao{
				escrevaLinha(verdadeiro, 24)
				escreva("    Opção inválida!\n")
				escrevaLinha(verdadeiro, 24)
				u.aguarde(1250)
				limpa()
				inicio()
			}
		}senao{
			se(opcao == 2){
				menuInicial()
			}senao se(opcao == 1){
				escrevaLinha(verdadeiro, 24)
				escreva("  Programa Finalizado!\n")
				escrevaLinha(verdadeiro, 24)
				u.aguarde(1000)
			}senao{
				escrevaLinha(verdadeiro, 24)
				escreva("    Opção inválida!\n")
				escrevaLinha(verdadeiro, 24)
				u.aguarde(1250)
				limpa()
				menuInicial()
			}
		}
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 13348; 
 * @DOBRAMENTO-CODIGO = [16, 31, 72, 102, 151, 192, 227, 268, 304, 341, 403, 438, 459, 478, 511, 554, 586, 721, 752, 832];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */