programa //Aplicativo de banco
{
	inclua biblioteca Util --> u
	inclua biblioteca Tipos --> tip
	inclua biblioteca Arquivos --> a
	inclua biblioteca Texto --> tx
	inclua biblioteca Teclado --> t
	inclua biblioteca Graficos --> g
	inclua biblioteca Mouse --> m
	
	cadeia nome, sobrenome, idade, cpf, operadora, celular, login, senha, agencia, conta, saldoTx, texto = ""
	inteiro opcao, entrar
	real transferir, valor, saldo

	//Posições para a tela
	const inteiro LARGURA_DA_TELA = 400, ALTURA_DA_TELA = 600
	inteiro imagem_de_fundo = 0

 	//Posições do mouse
	inteiro posX, posY
	
	funcao inicio()
	{
		inicializar()
		menuLogin()
		
		g.liberar_imagem(imagem_de_fundo)
		g.encerrar_modo_grafico()
	}

	funcao inicializar()//Inicia o modo gráfico
	{
		cadeia fundo = u.obter_diretorio_usuario()+"/Desktop/"
		cadeia pasta_imagens = fundo
		
		imagem_de_fundo = g.carregar_imagem(pasta_imagens + "fundo.jpg")
		
		g.iniciar_modo_grafico(falso)
		g.definir_dimensoes_janela(LARGURA_DA_TELA, ALTURA_DA_TELA)
		g.definir_titulo_janela("TechBank")

		g.desenhar_imagem(0, 0, imagem_de_fundo)
		g.definir_cor(g.COR_BRANCO)
		g.definir_estilo_texto(falso, verdadeiro, falso)
		g.desenhar_retangulo(60, 420, 100, 50, verdadeiro, falso)
		g.desenhar_texto(92, 440, "LOGIN")
		g.desenhar_retangulo(235, 420, 100, 50, verdadeiro, falso)
		g.desenhar_texto(253, 440, "CADASTRO")
		g.renderizar()
	}
	
	funcao menuInicial()//Menu conta usuário
	{
		saldo = obterSaldo()
		saldoTx = tip.real_para_cadeia(saldo)
		g.desenhar_imagem(0, 0, imagem_de_fundo)
		g.definir_cor(g.COR_BRANCO)
		g.desenhar_texto(270, 310, "SALDO R$")
		g.desenhar_texto(335, 310, saldoTx)
		g.desenhar_retangulo(60, 380, 120, 50, verdadeiro, falso)
		g.desenhar_texto(70, 400, "TRANSFERÊNCIA")
		g.desenhar_retangulo(220, 380, 120, 50, verdadeiro, falso)
		g.desenhar_texto(243, 400, "PAGAMENTO")
		g.desenhar_retangulo(60, 460, 120, 50, verdadeiro, falso)
		g.desenhar_texto(90, 480, "RECARGA")
		g.desenhar_retangulo(220, 460, 120, 50, verdadeiro, falso)
		g.desenhar_texto(253, 480, "SUPORTE")
		g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
		g.desenhar_texto(287, 560, "DESCONECTAR")
		g.renderizar()
		
		enquanto(nao t.tecla_pressionada(t.TECLA_ESC)){
			se(m.botao_pressionado(m.BOTAO_ESQUERDO)){
				u.aguarde(150)
				posX = m.posicao_x()
				posY = m.posicao_y()
				
				se((posX >= 60 e posX <= 180) e (posY >= 380 e posY <= 430)){ //Transferencia
					transferencia()
				}senao se((posX >= 220 e posX <= 340) e (posY >= 380 e posY <= 430)){ //Pagamento
					pagamento()
				}senao se((posX >= 60 e posX <= 180) e (posY >= 460 e posY <= 510)){ //Recarga
					recarga()
				}senao se((posX >= 220 e posX <= 340) e (posY >= 460 e posY <= 510)){ //Suporte
					suporte()
				}senao se((posX >= 280 e posX <= 380) e (posY >= 550 e posY <= 580)){ //Desconectar
					inicio()
				}
				
				g.desenhar_imagem(0, 0, imagem_de_fundo)
				g.definir_cor(g.COR_BRANCO)
				g.desenhar_texto(270, 310, "SALDO R$")
				g.desenhar_texto(335, 310, saldoTx)
				g.desenhar_retangulo(60, 380, 120, 50, verdadeiro, falso)
				g.desenhar_texto(70, 400, "TRANSFERÊNCIA")
				g.desenhar_retangulo(220, 380, 120, 50, verdadeiro, falso)
				g.desenhar_texto(243, 400, "PAGAMENTO")
				g.desenhar_retangulo(60, 460, 120, 50, verdadeiro, falso)
				g.desenhar_texto(90, 480, "RECARGA")
				g.desenhar_retangulo(220, 460, 120, 50, verdadeiro, falso)
				g.desenhar_texto(253, 480, "SUPORTE")
				g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
				g.desenhar_texto(287, 560, "DESCONECTAR")
				g.renderizar()
			}
		}
	}
	
	funcao menuLogin()//Menu de seleção para Login ou Registro
	{
		enquanto(nao t.tecla_pressionada(t.TECLA_ESC)){
			se(m.botao_pressionado(m.BOTAO_ESQUERDO)){
				u.aguarde(150)
				posX = m.posicao_x()
				posY = m.posicao_y()
				
				se((posX >= 60 e posX <= 160) e (posY >= 420 e posY <= 470)){ //Login
					Login()
				}senao se((posX >= 235 e posX <= 335) e (posY >= 420 e posY <= 470)){ //cadastro
					Cadastro()
				}
				
				g.desenhar_imagem(0, 0, imagem_de_fundo)
				g.definir_cor(g.COR_BRANCO)
				g.desenhar_retangulo(60, 420, 100, 50, verdadeiro, falso)
				g.desenhar_retangulo(235, 420, 100, 50, verdadeiro, falso)
				g.desenhar_texto(92, 440, "LOGIN")
				g.desenhar_texto(253, 440, "CADASTRO")
				g.renderizar()
			}
		}
	}

	funcao Login()//Acessar conta
	{
		texto = ""
		
		g.desenhar_imagem(0, 0, imagem_de_fundo)
		g.definir_cor(g.COR_BRANCO)
		g.desenhar_texto(330, 300, "LOGIN")
		g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
		g.desenhar_texto(135, 385, "DIGITE A AGÊNCIA")
		g.desenhar_texto(50, 410, texto + "_")
		g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
		g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
		g.desenhar_texto(308, 560, "VOLTAR")
		g.renderizar()
		
		enquanto(t.tecla_pressionada(t.TECLA_ENTER) == falso){
			se(m.botao_pressionado(m.BOTAO_ESQUERDO)){
				u.aguarde(150)
				posX = m.posicao_x()
				posY = m.posicao_y()
					
				se((posX >= 280 e posX <= 380) e (posY >= 550 e posY <= 580)){ //Voltar
					inicio()
				}
			}
			
			se(t.alguma_tecla_pressionada() == verdadeiro){
				se(t.tecla_pressionada(t.TECLA_ENTER)){
					
				}senao se(t.tecla_pressionada(t.TECLA_BACKSPACE)){
					u.aguarde(150)
					inteiro nC
					nC = tx.numero_caracteres(texto)
					nC -= 1
					texto = tx.extrair_subtexto(texto, 0, nC)
					
					g.desenhar_imagem(0, 0, imagem_de_fundo)
					g.definir_cor(g.COR_BRANCO)
					g.desenhar_texto(330, 300, "LOGIN")
					g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
					g.desenhar_texto(135, 385, "DIGITE A AGÊNCIA")
					g.desenhar_texto(50, 410, texto + "_")
					g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
					g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
					g.desenhar_texto(308, 560, "VOLTAR")
					g.renderizar()
				}senao{
					texto += t.caracter_tecla(t.ler_tecla())
					
					g.desenhar_imagem(0, 0, imagem_de_fundo)
					g.definir_cor(g.COR_BRANCO)
					g.desenhar_texto(330, 300, "LOGIN")
					g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
					g.desenhar_texto(135, 385, "DIGITE A AGÊNCIA")
					g.desenhar_texto(50, 410, texto + "_")
					g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
					g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
					g.desenhar_texto(308, 560, "VOLTAR")
					g.renderizar()
				}
			}
		}
		login = texto
		u.aguarde(200)

		texto = ""
		g.desenhar_imagem(0, 0, imagem_de_fundo)
		g.definir_cor(g.COR_BRANCO)
		g.desenhar_texto(330, 300, "LOGIN")
		g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
		g.desenhar_texto(140, 385, "DIGITE A CONTA")
		g.desenhar_texto(50, 410, texto + "_")
		g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
		g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
		g.desenhar_texto(308, 560, "VOLTAR")
		g.renderizar()
		
		enquanto(t.tecla_pressionada(t.TECLA_ENTER) == falso){
			se(m.botao_pressionado(m.BOTAO_ESQUERDO)){
				u.aguarde(150)
				posX = m.posicao_x()
				posY = m.posicao_y()
					
				se((posX >= 280 e posX <= 380) e (posY >= 550 e posY <= 580)){ //Voltar
					Login()
				}
			}
			
			se(t.alguma_tecla_pressionada() == verdadeiro){
				se(t.tecla_pressionada(t.TECLA_ENTER)){
					
				}senao se(t.tecla_pressionada(t.TECLA_BACKSPACE)){
					u.aguarde(150)
					inteiro nC
					nC = tx.numero_caracteres(texto)
					nC -= 1
					texto = tx.extrair_subtexto(texto, 0, nC)
					
					g.desenhar_imagem(0, 0, imagem_de_fundo)
					g.definir_cor(g.COR_BRANCO)
					g.desenhar_texto(330, 300, "LOGIN")
					g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
					g.desenhar_texto(140, 385, "DIGITE A CONTA")
					g.desenhar_texto(50, 410, texto + "_")
					g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
					g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
					g.desenhar_texto(308, 560, "VOLTAR")
					g.renderizar()
				}senao{
					texto += t.caracter_tecla(t.ler_tecla())
					
					g.desenhar_imagem(0, 0, imagem_de_fundo)
					g.definir_cor(g.COR_BRANCO)
					g.desenhar_texto(330, 300, "LOGIN")
					g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
					g.desenhar_texto(140, 385, "DIGITE A CONTA")
					g.desenhar_texto(50, 410, texto + "_")
					g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
					g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
					g.desenhar_texto(308, 560, "VOLTAR")
					g.renderizar()
				}
			}
		}
		senha = texto
		u.aguarde(150)
		
		se(entrarConta()==-1){
			menuInicial()
		}senao se(entrarConta()==0){
			g.desenhar_imagem(0, 0, imagem_de_fundo)
			g.definir_cor(g.COR_BRANCO)
			g.desenhar_texto(330, 300, "LOGIN")
			g.desenhar_texto(103, 410, "AGÊNCIA OU CONTA INVÁLIDA!")
			g.renderizar()
			u.aguarde(1750)
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
		//Digitar o nome vvvv
		texto = ""
		
		g.desenhar_imagem(0, 0, imagem_de_fundo)
		g.definir_cor(g.COR_BRANCO)
		g.desenhar_texto(310, 300, "CADASTRO")
		g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
		g.desenhar_texto(145, 385, "DIGITE O NOME")
		g.desenhar_texto(50, 410, texto + "_")
		g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
		g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
		g.desenhar_texto(308, 560, "VOLTAR")
		g.renderizar()
		
		enquanto(t.tecla_pressionada(t.TECLA_ENTER) == falso){
			se(m.botao_pressionado(m.BOTAO_ESQUERDO)){
				u.aguarde(150)
				posX = m.posicao_x()
				posY = m.posicao_y()
					
				se((posX >= 280 e posX <= 380) e (posY >= 550 e posY <= 580)){ //Voltar
					inicio()
				}
			}
			
			se(t.alguma_tecla_pressionada() == verdadeiro){
				se(t.tecla_pressionada(t.TECLA_ENTER)){
					
				}senao se(t.tecla_pressionada(t.TECLA_BACKSPACE)){
					u.aguarde(150)
					inteiro nC
					nC = tx.numero_caracteres(texto)
					nC -= 1
					texto = tx.extrair_subtexto(texto, 0, nC)
					
					g.desenhar_imagem(0, 0, imagem_de_fundo)
					g.definir_cor(g.COR_BRANCO)
					g.desenhar_texto(310, 300, "CADASTRO")
					g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
					g.desenhar_texto(145, 385, "DIGITE O NOME")
					g.desenhar_texto(50, 410, texto + "_")
					g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
					g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
					g.desenhar_texto(308, 560, "VOLTAR")
					g.renderizar()
				}senao{
					texto += t.caracter_tecla(t.ler_tecla())
					
					g.desenhar_imagem(0, 0, imagem_de_fundo)
					g.definir_cor(g.COR_BRANCO)
					g.desenhar_texto(310, 300, "CADASTRO")
					g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
					g.desenhar_texto(145, 385, "DIGITE O NOME")
					g.desenhar_texto(50, 410, texto + "_")
					g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
					g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
					g.desenhar_texto(308, 560, "VOLTAR")
					g.renderizar()
				}
			}
		}
		nome = texto
		u.aguarde(200)
		
		//Digitar o sobrenome vvvv
		texto = ""
		g.desenhar_imagem(0, 0, imagem_de_fundo)
		g.definir_cor(g.COR_BRANCO)
		g.desenhar_texto(310, 300, "CADASTRO")
		g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
		g.desenhar_texto(125, 385, "DIGITE O SOBRENOME")
		g.desenhar_texto(50, 410, texto + "_")
		g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
		g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
		g.desenhar_texto(300, 560, "CANCELAR")
		g.renderizar()
		
		enquanto(t.tecla_pressionada(t.TECLA_ENTER) == falso){
			se(m.botao_pressionado(m.BOTAO_ESQUERDO)){
				u.aguarde(150)
				posX = m.posicao_x()
				posY = m.posicao_y()
					
				se((posX >= 280 e posX <= 380) e (posY >= 550 e posY <= 580)){ //Cancelar
					inicio()
				}
			}
			
			se(t.alguma_tecla_pressionada() == verdadeiro){
				se(t.tecla_pressionada(t.TECLA_ENTER)){
					
				}senao se(t.tecla_pressionada(t.TECLA_BACKSPACE)){
					u.aguarde(150)
					inteiro nC
					nC = tx.numero_caracteres(texto)
					nC -= 1
					texto = tx.extrair_subtexto(texto, 0, nC)
					
					g.desenhar_imagem(0, 0, imagem_de_fundo)
					g.definir_cor(g.COR_BRANCO)
					g.desenhar_texto(310, 300, "CADASTRO")
					g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
					g.desenhar_texto(125, 385, "DIGITE O SOBRENOME")
					g.desenhar_texto(50, 410, texto + "_")
					g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
					g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
					g.desenhar_texto(300, 560, "CANCELAR")
					g.renderizar()
				}senao{
					texto += t.caracter_tecla(t.ler_tecla())
					
					g.desenhar_imagem(0, 0, imagem_de_fundo)
					g.definir_cor(g.COR_BRANCO)
					g.desenhar_texto(310, 300, "CADASTRO")
					g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
					g.desenhar_texto(125, 385, "DIGITE O SOBRENOME")
					g.desenhar_texto(50, 410, texto + "_")
					g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
					g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
					g.desenhar_texto(300, 560, "CANCELAR")
					g.renderizar()
				}
			}
		}
		sobrenome = texto
		u.aguarde(200)
		
		//Digitar a idade vvvv
		texto = ""
		g.desenhar_imagem(0, 0, imagem_de_fundo)
		g.definir_cor(g.COR_BRANCO)
		g.desenhar_texto(310, 300, "CADASTRO")
		g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
		g.desenhar_texto(140, 385, "DIGITE A IDADE")
		g.desenhar_texto(50, 410, texto + "_")
		g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
		g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
		g.desenhar_texto(300, 560, "CANCELAR")
		g.renderizar()
		
		enquanto(t.tecla_pressionada(t.TECLA_ENTER) == falso){
			se(m.botao_pressionado(m.BOTAO_ESQUERDO)){
				u.aguarde(150)
				posX = m.posicao_x()
				posY = m.posicao_y()
					
				se((posX >= 280 e posX <= 380) e (posY >= 550 e posY <= 580)){ //Cancelar
					inicio()
				}
			}
			
			se(t.alguma_tecla_pressionada() == verdadeiro){
				se(t.tecla_pressionada(t.TECLA_ENTER)){
					
				}senao se(t.tecla_pressionada(t.TECLA_BACKSPACE)){
					u.aguarde(150)
					inteiro nC
					nC = tx.numero_caracteres(texto)
					nC -= 1
					texto = tx.extrair_subtexto(texto, 0, nC)
					
					g.desenhar_imagem(0, 0, imagem_de_fundo)
					g.definir_cor(g.COR_BRANCO)
					g.desenhar_texto(310, 300, "CADASTRO")
					g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
					g.desenhar_texto(140, 385, "DIGITE A IDADE")
					g.desenhar_texto(50, 410, texto + "_")
					g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
					g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
					g.desenhar_texto(300, 560, "CANCELAR")
					g.renderizar()
				}senao{
					texto += t.caracter_tecla(t.ler_tecla())
					
					g.desenhar_imagem(0, 0, imagem_de_fundo)
					g.definir_cor(g.COR_BRANCO)
					g.desenhar_texto(310, 300, "CADASTRO")
					g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
					g.desenhar_texto(140, 385, "DIGITE A IDADE")
					g.desenhar_texto(50, 410, texto + "_")
					g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
					g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
					g.desenhar_texto(300, 560, "CANCELAR")
					g.renderizar()
				}
			}
		}
		idade = texto
		u.aguarde(200)
		
		//Digitar o cpf vvvv
		texto = ""
		g.desenhar_imagem(0, 0, imagem_de_fundo)
		g.definir_cor(g.COR_BRANCO)
		g.desenhar_texto(310, 300, "CADASTRO")
		g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
		g.desenhar_texto(150, 385, "DIGITE O CPF")
		g.desenhar_texto(50, 410, texto + "_")
		g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
		g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
		g.desenhar_texto(300, 560, "CANCELAR")
		g.renderizar()
		
		enquanto(t.tecla_pressionada(t.TECLA_ENTER) == falso){
			se(m.botao_pressionado(m.BOTAO_ESQUERDO)){
				u.aguarde(150)
				posX = m.posicao_x()
				posY = m.posicao_y()
					
				se((posX >= 280 e posX <= 380) e (posY >= 550 e posY <= 580)){ //Cancelar
					inicio()
				}
			}
			
			se(t.alguma_tecla_pressionada() == verdadeiro){
				se(t.tecla_pressionada(t.TECLA_ENTER)){
					
				}senao se(t.tecla_pressionada(t.TECLA_BACKSPACE)){
					u.aguarde(150)
					inteiro nC
					nC = tx.numero_caracteres(texto)
					nC -= 1
					texto = tx.extrair_subtexto(texto, 0, nC)
					
					g.desenhar_imagem(0, 0, imagem_de_fundo)
					g.definir_cor(g.COR_BRANCO)
					g.desenhar_texto(310, 300, "CADASTRO")
					g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
					g.desenhar_texto(150, 385, "DIGITE O CPF")
					g.desenhar_texto(50, 410, texto + "_")
					g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
					g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
					g.desenhar_texto(300, 560, "CANCELAR")
					g.renderizar()
				}senao{
					texto += t.caracter_tecla(t.ler_tecla())
					
					g.desenhar_imagem(0, 0, imagem_de_fundo)
					g.definir_cor(g.COR_BRANCO)
					g.desenhar_texto(310, 300, "CADASTRO")
					g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
					g.desenhar_texto(150, 385, "DIGITE O CPF")
					g.desenhar_texto(50, 410, texto + "_")
					g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
					g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
					g.desenhar_texto(300, 560, "CANCELAR")
					g.renderizar()
				}
			}
		}
		cpf = texto
		u.aguarde(150)

		gerarConta()
		
		g.desenhar_imagem(0, 0, imagem_de_fundo)
		g.definir_cor(g.COR_BRANCO)
		g.desenhar_texto(310, 300, "CADASTRO")
		g.desenhar_texto(75, 410, "CADASTRO CONCLUIDO COM SUCESSO!")
		g.renderizar()
		u.aguarde(1750)
		inicio()
	}
	
	funcao gerarConta()//Gerar número da conta
	{
		g.desenhar_imagem(0, 0, imagem_de_fundo)
		g.definir_cor(g.COR_BRANCO)
		g.desenhar_texto(310, 300, "CADASTRO")
		g.desenhar_texto(140, 410, "GERANDO A CONTA!")
		g.renderizar()
		u.aguarde(1750)
		
		inteiro n1 = u.sorteia(0,9), n2 = u.sorteia(0,9), n3 = u.sorteia(0,9), n4 = u.sorteia(0,9)
		cadeia n1t = tip.inteiro_para_cadeia(n1, 10), n2t = tip.inteiro_para_cadeia(n2, 10), n3t = tip.inteiro_para_cadeia(n3, 10), n4t = tip.inteiro_para_cadeia(n4, 10)
		agencia = n1t + n2t + n3t + n4t

		inteiro n5 = u.sorteia(0,9), n6 = u.sorteia(0,9), n7 = u.sorteia(0,9), n8 = u.sorteia(0,9), n9 = u.sorteia(0, 9)
		cadeia n5t = tip.inteiro_para_cadeia(n5, 10), n6t = tip.inteiro_para_cadeia(n6, 10), n7t = tip.inteiro_para_cadeia(n7, 10), n8t = tip.inteiro_para_cadeia(n8, 10), n9t = tip.inteiro_para_cadeia(n9, 10)
		conta = n5t + n6t + n7t + n8t + n9t
		
		enquanto(t.tecla_pressionada(t.TECLA_ENTER) == falso){
			g.desenhar_imagem(0, 0, imagem_de_fundo)
			g.definir_cor(g.COR_BRANCO)
			g.desenhar_texto(310, 300, "CADASTRO")
			g.desenhar_texto(140, 410, "AGÊNCIA: ")
			g.desenhar_texto(203, 410, agencia)
			
			g.desenhar_texto(140, 430, "CONTA: ")
			g.desenhar_texto(190, 430, conta)
			g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
			g.renderizar()
		}
		
		salvarConta()
		gerarSaldo(agencia, conta)
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
		//Digitar o destinatário vvvv
		texto = ""
		g.desenhar_imagem(0, 0, imagem_de_fundo)
		g.definir_cor(g.COR_BRANCO)
		g.desenhar_texto(280, 300, "TRANSFERÊNCIA")
		g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
		g.desenhar_texto(90, 385, "DIGITE A AGÊNCIA DO DESTINATÁRIO")
		g.desenhar_texto(50, 410, texto + "_")
		g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
		g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
		g.desenhar_texto(308, 560, "VOLTAR")
		g.renderizar()
		
		enquanto(t.tecla_pressionada(t.TECLA_ENTER) == falso){
			se(m.botao_pressionado(m.BOTAO_ESQUERDO)){
				u.aguarde(150)
				posX = m.posicao_x()
				posY = m.posicao_y()
					
				se((posX >= 280 e posX <= 380) e (posY >= 550 e posY <= 580)){ //Voltar
					menuInicial()
				}
			}
			
			se(t.alguma_tecla_pressionada() == verdadeiro){
				se(t.tecla_pressionada(t.TECLA_ENTER)){
					
				}senao se(t.tecla_pressionada(t.TECLA_BACKSPACE)){
					u.aguarde(150)
					inteiro nC
					nC = tx.numero_caracteres(texto)
					nC -= 1
					texto = tx.extrair_subtexto(texto, 0, nC)
					
					g.desenhar_imagem(0, 0, imagem_de_fundo)
					g.definir_cor(g.COR_BRANCO)
					g.desenhar_texto(280, 300, "TRANSFERÊNCIA")
					g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
					g.desenhar_texto(90, 385, "DIGITE A AGÊNCIA DO DESTINATÁRIO")
					g.desenhar_texto(50, 410, texto + "_")
					g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
					g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
					g.desenhar_texto(308, 560, "VOLTAR")
					g.renderizar()
				}senao{
					texto += t.caracter_tecla(t.ler_tecla())
					
					g.desenhar_imagem(0, 0, imagem_de_fundo)
					g.definir_cor(g.COR_BRANCO)
					g.desenhar_texto(280, 300, "TRANSFERÊNCIA")
					g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
					g.desenhar_texto(90, 385, "DIGITE A AGÊNCIA DO DESTINATÁRIO")
					g.desenhar_texto(50, 410, texto + "_")
					g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
					g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
					g.desenhar_texto(308, 560, "VOLTAR")
					g.renderizar()
				}
			}
		}
		agencia = texto
		u.aguarde(150)
		
		inteiro p = verificarAgencia(agencia)
		se(p == 0){
			g.desenhar_imagem(0, 0, imagem_de_fundo)
			g.definir_cor(g.COR_BRANCO)
			g.desenhar_texto(280, 300, "TRANSFERÊNCIA")
			g.desenhar_texto(100, 420, "DIGITE UMA AGÊNCIA VÁLIDA!")
			g.renderizar()
			u.aguarde(1750)
			menuInicial()
		}

		//Digitar o valor vvvv
		texto = ""
		g.desenhar_imagem(0, 0, imagem_de_fundo)
		g.definir_cor(g.COR_BRANCO)
		g.desenhar_texto(280, 300, "TRANSFERÊNCIA")
		g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
		g.desenhar_texto(85, 385, "DIGITE O VALOR DA TRANSFERÊNCIA")
		g.desenhar_texto(50, 410, texto + "_")
		g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
		g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
		g.desenhar_texto(300, 560, "CANCELAR")
		g.renderizar()
		
		enquanto(t.tecla_pressionada(t.TECLA_ENTER) == falso){
			se(m.botao_pressionado(m.BOTAO_ESQUERDO)){
				u.aguarde(150)
				posX = m.posicao_x()
				posY = m.posicao_y()
					
				se((posX >= 280 e posX <= 380) e (posY >= 550 e posY <= 580)){ //Voltar
					menuInicial()
				}
			}
			
			se(t.alguma_tecla_pressionada() == verdadeiro){
				se(t.tecla_pressionada(t.TECLA_ENTER)){
					
				}senao se(t.tecla_pressionada(t.TECLA_BACKSPACE)){
					u.aguarde(150)
					inteiro nC
					nC = tx.numero_caracteres(texto)
					nC -= 1
					texto = tx.extrair_subtexto(texto, 0, nC)
					
					g.desenhar_imagem(0, 0, imagem_de_fundo)
					g.definir_cor(g.COR_BRANCO)
					g.desenhar_texto(280, 300, "TRANSFERÊNCIA")
					g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
					g.desenhar_texto(85, 385, "DIGITE O VALOR DA TRANSFERÊNCIA")
					g.desenhar_texto(50, 410, texto + "_")
					g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
					g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
					g.desenhar_texto(300, 560, "CANCELAR")
					g.renderizar()
				}senao{
					texto += t.caracter_tecla(t.ler_tecla())
					
					g.desenhar_imagem(0, 0, imagem_de_fundo)
					g.definir_cor(g.COR_BRANCO)
					g.desenhar_texto(280, 300, "TRANSFERÊNCIA")
					g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
					g.desenhar_texto(85, 385, "DIGITE O VALOR DA TRANSFERÊNCIA")
					g.desenhar_texto(50, 410, texto + "_")
					g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
					g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
					g.desenhar_texto(300, 560, "CANCELAR")
					g.renderizar()
				}
			}
		}
		transferir = tip.cadeia_para_real(texto)
		u.aguarde(150)
		
		transferirSaldo(p, transferir)
		
		g.desenhar_imagem(0, 0, imagem_de_fundo)
		g.definir_cor(g.COR_BRANCO)
		g.desenhar_texto(280, 300, "TRANSFERÊNCIA")
		g.desenhar_texto(65, 410, "TRANSFERENCIA EFETUADA COM SUCESSO!")
		g.renderizar()
		u.aguarde(1750)
		menuInicial()
	}

	funcao pagamento()//Pagar boletos
	{
		inteiro n1, n2, n3, n4
		cadeia n1T, n2T, n3T, n4T
		logico voltar = falso
		n1 = u.sorteia(30, 500)
		n2 = u.sorteia(30, 500)
		n3 = u.sorteia(25, 100)
		n4 = u.sorteia(25, 100)

		n1T = tip.inteiro_para_cadeia(n1, 10)
		n2T = tip.inteiro_para_cadeia(n2, 10)
		n3T = tip.inteiro_para_cadeia(n3, 10)
		n4T = tip.inteiro_para_cadeia(n4, 10)
		
		g.desenhar_imagem(0, 0, imagem_de_fundo)
		g.definir_cor(g.COR_BRANCO)
		g.desenhar_texto(310, 300, "PAGAMENTO")
		g.desenhar_retangulo(60, 380, 120, 50, verdadeiro, falso)
		g.desenhar_texto(110, 400, "LUZ")
		g.desenhar_retangulo(220, 380, 120, 50, verdadeiro, falso)
		g.desenhar_texto(265, 400, "ÁGUA")
		g.desenhar_retangulo(60, 460, 120, 50, verdadeiro, falso)
		g.desenhar_texto(90, 480, "INTERNET")
		g.desenhar_retangulo(220, 460, 120, 50, verdadeiro, falso)
		g.desenhar_texto(270, 480, "GÁS")
		g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
		g.desenhar_texto(308, 560, "VOLTAR")
		g.renderizar()

		enquanto(nao t.tecla_pressionada(t.TECLA_ESC)){
			se(m.botao_pressionado(m.BOTAO_ESQUERDO)){
				u.aguarde(150)
				posX = m.posicao_x()
				posY = m.posicao_y()
				
				se((posX >= 60 e posX <= 180) e (posY >= 380 e posY <= 430)){ //Luz
					enquanto(voltar == falso){
						g.desenhar_imagem(0, 0, imagem_de_fundo)
						g.definir_cor(g.COR_BRANCO)
						g.desenhar_texto(310, 300, "PAGAMENTO")
						g.desenhar_texto(90, 385, "VALOR DA CONTA DE LUZ R$")
						g.desenhar_texto(270, 385, n1T + ".00")
						g.desenhar_retangulo(60, 460, 120, 50, verdadeiro, falso)
						g.desenhar_texto(100, 480, "PAGAR")
						g.desenhar_retangulo(220, 460, 120, 50, verdadeiro, falso)
						g.desenhar_texto(258, 480, "VOLTAR")
						g.renderizar()
						
						se(m.botao_pressionado(m.BOTAO_ESQUERDO)){
							u.aguarde(150)
							posX = m.posicao_x()
							posY = m.posicao_y()

							 se((posX >= 60 e posX <= 180) e (posY >= 460 e posY <= 510)){ //Pagar
								real local = saldo
								extrairSaldo(local, n1)
								saldo = local

								g.desenhar_imagem(0, 0, imagem_de_fundo)
								g.definir_cor(g.COR_BRANCO)
								g.desenhar_texto(310, 300, "PAGAMENTO")
								g.desenhar_texto(85, 410, "PAGAMENTO EFETUADO COM SUCESSO!")
								g.renderizar()
								u.aguarde(1750)
		
							 	voltar = verdadeiro
							 }senao se((posX >= 220 e posX <= 340) e (posY >= 460 e posY <= 510)){ //Voltar
							 	voltar = verdadeiro
							 }
						}
					}
					voltar = falso
				}senao se((posX >= 220 e posX <= 340) e (posY >= 380 e posY <= 430)){ //Água
					enquanto(voltar == falso){
						g.desenhar_imagem(0, 0, imagem_de_fundo)
						g.definir_cor(g.COR_BRANCO)
						g.desenhar_texto(310, 300, "PAGAMENTO")
						g.desenhar_texto(83, 385, "VALOR DA CONTA DE ÁGUA R$")
						g.desenhar_texto(273, 385, n2T + ".00")
						g.desenhar_retangulo(60, 460, 120, 50, verdadeiro, falso)
						g.desenhar_texto(100, 480, "PAGAR")
						g.desenhar_retangulo(220, 460, 120, 50, verdadeiro, falso)
						g.desenhar_texto(258, 480, "VOLTAR")
						g.renderizar()
						
						se(m.botao_pressionado(m.BOTAO_ESQUERDO)){
							u.aguarde(150)
							posX = m.posicao_x()
							posY = m.posicao_y()

							 se((posX >= 60 e posX <= 180) e (posY >= 460 e posY <= 510)){ //Pagar
								real local = saldo
								extrairSaldo(local, n2)
								saldo = local

								g.desenhar_imagem(0, 0, imagem_de_fundo)
								g.definir_cor(g.COR_BRANCO)
								g.desenhar_texto(310, 300, "PAGAMENTO")
								g.desenhar_texto(85, 410, "PAGAMENTO EFETUADO COM SUCESSO!")
								g.renderizar()
								u.aguarde(1750)
		
							 	voltar = verdadeiro
							 }senao se((posX >= 220 e posX <= 340) e (posY >= 460 e posY <= 510)){ //Voltar
							 	voltar = verdadeiro
							 }
						}
					}
					voltar = falso
				}senao se((posX >= 60 e posX <= 180) e (posY >= 460 e posY <= 510)){ //Internet
					enquanto(voltar == falso){
						g.desenhar_imagem(0, 0, imagem_de_fundo)
						g.definir_cor(g.COR_BRANCO)
						g.desenhar_texto(310, 300, "PAGAMENTO")
						g.desenhar_texto(68, 385, "VALOR DA CONTA DE INTERNET R$")
						g.desenhar_texto(285, 385, n3T + ".00")
						g.desenhar_retangulo(60, 460, 120, 50, verdadeiro, falso)
						g.desenhar_texto(100, 480, "PAGAR")
						g.desenhar_retangulo(220, 460, 120, 50, verdadeiro, falso)
						g.desenhar_texto(258, 480, "VOLTAR")
						g.renderizar()
						
						se(m.botao_pressionado(m.BOTAO_ESQUERDO)){
							u.aguarde(150)
							posX = m.posicao_x()
							posY = m.posicao_y()

							 se((posX >= 60 e posX <= 180) e (posY >= 460 e posY <= 510)){ //Pagar
								real local = saldo
								extrairSaldo(local, n3)
								saldo = local

								g.desenhar_imagem(0, 0, imagem_de_fundo)
								g.definir_cor(g.COR_BRANCO)
								g.desenhar_texto(310, 300, "PAGAMENTO")
								g.desenhar_texto(85, 410, "PAGAMENTO EFETUADO COM SUCESSO!")
								g.renderizar()
								u.aguarde(1750)
		
							 	voltar = verdadeiro
							 }senao se((posX >= 220 e posX <= 340) e (posY >= 460 e posY <= 510)){ //Voltar
							 	voltar = verdadeiro
							 }
						}
					}
					voltar = falso
				}senao se((posX >= 220 e posX <= 340) e (posY >= 460 e posY <= 510)){ //Gás
					enquanto(voltar == falso){
						g.desenhar_imagem(0, 0, imagem_de_fundo)
						g.definir_cor(g.COR_BRANCO)
						g.desenhar_texto(310, 300, "PAGAMENTO")
						g.desenhar_texto(90, 385, "VALOR DA CONTA DE LUZ R$")
						g.desenhar_texto(270, 385, n4T + ".00")
						g.desenhar_retangulo(60, 460, 120, 50, verdadeiro, falso)
						g.desenhar_texto(100, 480, "PAGAR")
						g.desenhar_retangulo(220, 460, 120, 50, verdadeiro, falso)
						g.desenhar_texto(258, 480, "VOLTAR")
						g.renderizar()
						
						se(m.botao_pressionado(m.BOTAO_ESQUERDO)){
							u.aguarde(150)
							posX = m.posicao_x()
							posY = m.posicao_y()

							 se((posX >= 60 e posX <= 180) e (posY >= 460 e posY <= 510)){ //Pagar
								real local = saldo
								extrairSaldo(local, n4)
								saldo = local

								g.desenhar_imagem(0, 0, imagem_de_fundo)
								g.definir_cor(g.COR_BRANCO)
								g.desenhar_texto(310, 300, "PAGAMENTO")
								g.desenhar_texto(85, 410, "PAGAMENTO EFETUADO COM SUCESSO!")
								g.renderizar()
								u.aguarde(1750)
		
							 	voltar = verdadeiro
							 }senao se((posX >= 220 e posX <= 340) e (posY >= 460 e posY <= 510)){ //Voltar
							 	voltar = verdadeiro
							 }
						}
					}
					voltar = falso
				}senao se((posX >= 280 e posX <= 380) e (posY >= 550 e posY <= 580)){ //Voltar
					menuInicial()
				}
				
				g.desenhar_imagem(0, 0, imagem_de_fundo)
				g.definir_cor(g.COR_BRANCO)
				g.desenhar_texto(310, 300, "PAGAMENTO")
				g.desenhar_retangulo(60, 380, 120, 50, verdadeiro, falso)
				g.desenhar_texto(110, 400, "LUZ")
				g.desenhar_retangulo(220, 380, 120, 50, verdadeiro, falso)
				g.desenhar_texto(265, 400, "ÁGUA")
				g.desenhar_retangulo(60, 460, 120, 50, verdadeiro, falso)
				g.desenhar_texto(90, 480, "INTERNET")
				g.desenhar_retangulo(220, 460, 120, 50, verdadeiro, falso)
				g.desenhar_texto(270, 480, "GÁS")
				g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
				g.desenhar_texto(308, 560, "VOLTAR")
				g.renderizar()
			}
		}
	}

	funcao recarga()//Recarregar crédito celular
	{
		texto = ""
		
		g.desenhar_imagem(0, 0, imagem_de_fundo)
		g.definir_cor(g.COR_BRANCO)
		g.desenhar_texto(320, 300, "RECARGA")
		g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
		g.desenhar_texto(80, 385, "DIGITE A OPERADORA DO DISPOSITIVO")
		g.desenhar_texto(50, 410, texto + "_")
		g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
		g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
		g.desenhar_texto(308, 560, "VOLTAR")
		g.renderizar()
		
		enquanto(t.tecla_pressionada(t.TECLA_ENTER) == falso){
			se(m.botao_pressionado(m.BOTAO_ESQUERDO)){
				u.aguarde(150)
				posX = m.posicao_x()
				posY = m.posicao_y()
					
				se((posX >= 280 e posX <= 380) e (posY >= 550 e posY <= 580)){ //Voltar
					menuInicial()
				}
			}
			
			se(t.alguma_tecla_pressionada() == verdadeiro){
				se(t.tecla_pressionada(t.TECLA_ENTER)){
					
				}senao se(t.tecla_pressionada(t.TECLA_BACKSPACE)){
					u.aguarde(150)
					inteiro nC
					nC = tx.numero_caracteres(texto)
					nC -= 1
					texto = tx.extrair_subtexto(texto, 0, nC)
					
					g.desenhar_imagem(0, 0, imagem_de_fundo)
					g.definir_cor(g.COR_BRANCO)
					g.desenhar_texto(320, 300, "RECARGA")
					g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
					g.desenhar_texto(80, 385, "DIGITE A OPERADORA DO DISPOSITIVO")
					g.desenhar_texto(50, 410, texto + "_")
					g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
					g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
					g.desenhar_texto(308, 560, "VOLTAR")
					g.renderizar()
				}senao{
					texto += t.caracter_tecla(t.ler_tecla())
					
					g.desenhar_imagem(0, 0, imagem_de_fundo)
					g.definir_cor(g.COR_BRANCO)
					g.desenhar_texto(320, 300, "RECARGA")
					g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
					g.desenhar_texto(80, 385, "DIGITE A OPERADORA DO DISPOSITIVO")
					g.desenhar_texto(50, 410, texto + "_")
					g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
					g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
					g.desenhar_texto(308, 560, "VOLTAR")
					g.renderizar()
				}
			}
		}
		operadora = texto
		u.aguarde(150)

		texto = ""
		g.desenhar_imagem(0, 0, imagem_de_fundo)
		g.definir_cor(g.COR_BRANCO)
		g.desenhar_texto(320, 300, "RECARGA")
		g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
		g.desenhar_texto(95, 385, "DIGITE O NÚMERO DO DISPOSITIVO")
		g.desenhar_texto(50, 410, texto + "_")
		g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
		g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
		g.desenhar_texto(308, 560, "VOLTAR")
		g.renderizar()
		
		enquanto(t.tecla_pressionada(t.TECLA_ENTER) == falso){
			se(m.botao_pressionado(m.BOTAO_ESQUERDO)){
				u.aguarde(150)
				posX = m.posicao_x()
				posY = m.posicao_y()
					
				se((posX >= 280 e posX <= 380) e (posY >= 550 e posY <= 580)){ //Voltar
					recarga()
				}
			}
			
			se(t.alguma_tecla_pressionada() == verdadeiro){
				se(t.tecla_pressionada(t.TECLA_ENTER)){
					
				}senao se(t.tecla_pressionada(t.TECLA_BACKSPACE)){
					u.aguarde(150)
					inteiro nC
					nC = tx.numero_caracteres(texto)
					nC -= 1
					texto = tx.extrair_subtexto(texto, 0, nC)
					
					g.desenhar_imagem(0, 0, imagem_de_fundo)
					g.definir_cor(g.COR_BRANCO)
					g.desenhar_texto(320, 300, "RECARGA")
					g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
					g.desenhar_texto(95, 385, "DIGITE O NÚMERO DO DISPOSITIVO")
					g.desenhar_texto(50, 410, texto + "_")
					g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
					g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
					g.desenhar_texto(308, 560, "VOLTAR")
					g.renderizar()
				}senao{
					texto += t.caracter_tecla(t.ler_tecla())
					
					g.desenhar_imagem(0, 0, imagem_de_fundo)
					g.definir_cor(g.COR_BRANCO)
					g.desenhar_texto(320, 300, "RECARGA")
					g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
					g.desenhar_texto(95, 385, "DIGITE O NÚMERO DO DISPOSITIVO")
					g.desenhar_texto(50, 410, texto + "_")
					g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
					g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
					g.desenhar_texto(308, 560, "VOLTAR")
					g.renderizar()
				}
			}
		}
		celular = texto
		u.aguarde(150)

		texto = ""
		g.desenhar_imagem(0, 0, imagem_de_fundo)
		g.definir_cor(g.COR_BRANCO)
		g.desenhar_texto(320, 300, "RECARGA")
		g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
		g.desenhar_texto(105, 385, "DIGITE O VALOR DA RECARGA")
		g.desenhar_texto(50, 410, texto + "_")
		g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
		g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
		g.desenhar_texto(300, 560, "CANCELAR")
		g.renderizar()
		
		enquanto(t.tecla_pressionada(t.TECLA_ENTER) == falso){
			se(m.botao_pressionado(m.BOTAO_ESQUERDO)){
				u.aguarde(150)
				posX = m.posicao_x()
				posY = m.posicao_y()
					
				se((posX >= 280 e posX <= 380) e (posY >= 550 e posY <= 580)){ //Voltar
					menuInicial()
				}
			}
			
			se(t.alguma_tecla_pressionada() == verdadeiro){
				se(t.tecla_pressionada(t.TECLA_ENTER)){
					
				}senao se(t.tecla_pressionada(t.TECLA_BACKSPACE)){
					u.aguarde(150)
					inteiro nC
					nC = tx.numero_caracteres(texto)
					nC -= 1
					texto = tx.extrair_subtexto(texto, 0, nC)
					
					g.desenhar_imagem(0, 0, imagem_de_fundo)
					g.definir_cor(g.COR_BRANCO)
					g.desenhar_texto(320, 300, "RECARGA")
					g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
					g.desenhar_texto(105, 385, "DIGITE O VALOR DA RECARGA")
					g.desenhar_texto(50, 410, texto + "_")
					g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
					g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
					g.desenhar_texto(300, 560, "CANCELAR")
					g.renderizar()
				}senao{
					texto += t.caracter_tecla(t.ler_tecla())
					
					g.desenhar_imagem(0, 0, imagem_de_fundo)
					g.definir_cor(g.COR_BRANCO)
					g.desenhar_texto(320, 300, "RECARGA")
					g.desenhar_retangulo(40, 405, 320, 20, verdadeiro, falso)
					g.desenhar_texto(105, 385, "DIGITE O VALOR DA RECARGA")
					g.desenhar_texto(50, 410, texto + "_")
					g.desenhar_texto(130, 470, "ENTER PARA SEGUIR")
					g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
					g.desenhar_texto(300, 560, "CANCELAR")
					g.renderizar()
				}
			}
		}
		valor = tip.cadeia_para_real(texto)
		u.aguarde(150)
		
		real local = saldo
		extrairSaldo( local, valor)
		saldo = local
		
		g.desenhar_imagem(0, 0, imagem_de_fundo)
		g.definir_cor(g.COR_BRANCO)
		g.desenhar_texto(320, 300, "RECARGA")
		g.desenhar_texto(90, 410, "RECARGA EFETUADA COM SUCESSO!")
		g.renderizar()
		u.aguarde(1750)
		menuInicial()
	}

	funcao suporte()//Ajuda ao usuário
	{
		g.desenhar_imagem(0, 0, imagem_de_fundo)
		g.definir_cor(g.COR_BRANCO)
		g.desenhar_texto(320, 300, "SUPORTE")
		g.desenhar_retangulo(60, 380, 120, 50, verdadeiro, falso)
		g.desenhar_texto(70, 400, "TRANSFERÊNCIA")
		g.desenhar_retangulo(220, 380, 120, 50, verdadeiro, falso)
		g.desenhar_texto(243, 400, "PAGAMENTO")
		g.desenhar_retangulo(60, 460, 120, 50, verdadeiro, falso)
		g.desenhar_texto(90, 480, "RECARGA")
		g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
		g.desenhar_texto(308, 560, "VOLTAR")
		g.renderizar()

		enquanto(nao t.tecla_pressionada(t.TECLA_ESC)){
			se(m.botao_pressionado(m.BOTAO_ESQUERDO)){
				u.aguarde(150)
				posX = m.posicao_x()
				posY = m.posicao_y()
				
				se((posX >= 60 e posX <= 180) e (posY >= 380 e posY <= 430)){ //Transferencia
					g.desenhar_imagem(0, 0, imagem_de_fundo)
					g.definir_cor(g.COR_BRANCO)
					g.desenhar_texto(320, 300, "SUPORTE")
					g.desenhar_texto(90, 400, "NO MENU, SELECIONE TRANSFERÊNCIA")
					g.desenhar_texto(90, 420, "DIGITE A AGÊNCIA DO DESTINATÁRIO")
					g.desenhar_texto(90, 440, "E DIGITE O VALOR DA TRANSFERÊNCIA")
					g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
					g.desenhar_texto(308, 560, "VOLTAR")
					g.renderizar()
					
					enquanto(nao t.tecla_pressionada(t.TECLA_ESC)){
						se(m.botao_pressionado(m.BOTAO_ESQUERDO)){
							u.aguarde(150)
							posX = m.posicao_x()
							posY = m.posicao_y()
							se((posX >= 280 e posX <= 380) e (posY >= 550 e posY <= 580)){ //Voltar
								suporte()
							}
						}
					}
				}senao se((posX >= 220 e posX <= 340) e (posY >= 380 e posY <= 430)){ //Pagamento
					g.desenhar_imagem(0, 0, imagem_de_fundo)
					g.definir_cor(g.COR_BRANCO)
					g.desenhar_texto(320, 300, "SUPORTE")
					g.desenhar_texto(100, 400, "NO MENU, SELECIONE PAGAMENTO")
					g.desenhar_texto(80, 420, "SELECIONE A CONTA QUE DESEJA PAGAR")
					g.desenhar_texto(110, 440, "E SELECIONE A OPÇÃO PAGAR")
					g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
					g.desenhar_texto(308, 560, "VOLTAR")
					g.renderizar()
					
					enquanto(nao t.tecla_pressionada(t.TECLA_ESC)){
						se(m.botao_pressionado(m.BOTAO_ESQUERDO)){
							u.aguarde(150)
							posX = m.posicao_x()
							posY = m.posicao_y()
							se((posX >= 280 e posX <= 380) e (posY >= 550 e posY <= 580)){ //Voltar
								suporte()
							}
						}
					}
				}senao se((posX >= 60 e posX <= 180) e (posY >= 460 e posY <= 510)){ //Recarga
					g.desenhar_imagem(0, 0, imagem_de_fundo)
					g.definir_cor(g.COR_BRANCO)
					g.desenhar_texto(320, 300, "SUPORTE")
					g.desenhar_texto(105, 400, "NO MENU, SELECIONE RECARGA")
					g.desenhar_texto(80, 420, "DIGITE A OPERADORA DO DISPOSITIVO")
					g.desenhar_texto(93, 440, "DIGITE O NÚMERO DO DISPOSITIVO")
					g.desenhar_texto(100, 460, "E DIGITE O VALOR DA RECARGA")
					g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
					g.desenhar_texto(308, 560, "VOLTAR")
					g.renderizar()
					
					enquanto(nao t.tecla_pressionada(t.TECLA_ESC)){
						se(m.botao_pressionado(m.BOTAO_ESQUERDO)){
							u.aguarde(150)
							posX = m.posicao_x()
							posY = m.posicao_y()
							se((posX >= 280 e posX <= 380) e (posY >= 550 e posY <= 580)){ //Voltar
								suporte()
							}
						}
					}
				}senao se((posX >= 280 e posX <= 380) e (posY >= 550 e posY <= 580)){ //Voltar
					menuInicial()
				}
				g.desenhar_imagem(0, 0, imagem_de_fundo)
				g.definir_cor(g.COR_BRANCO)
				g.desenhar_texto(320, 300, "SUPORTE")
				g.desenhar_retangulo(60, 380, 120, 50, verdadeiro, falso)
				g.desenhar_texto(70, 400, "TRANSFERÊNCIA")
				g.desenhar_retangulo(220, 380, 120, 50, verdadeiro, falso)
				g.desenhar_texto(243, 400, "PAGAMENTO")
				g.desenhar_retangulo(60, 460, 120, 50, verdadeiro, falso)
				g.desenhar_texto(90, 480, "RECARGA")
				g.desenhar_retangulo(280, 550, 100, 30, verdadeiro, falso)
				g.desenhar_texto(308, 560, "VOLTAR")
				g.renderizar()
			}
		}
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 616; 
 * @DOBRAMENTO-CODIGO = [30, 51, 108, 133, 273, 314, 349, 390, 426, 463, 729, 763, 784, 803, 836, 879, 1029, 1235, 1437];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */