# Desafio — Ataques de Força Bruta com Kali + Medusa (Projeto DIO)

Resumo
Este repositório contém a documentação, wordlists e scripts de apoio para executar testes controlados de força bruta usando Kali Linux e Medusa contra VMs vulneráveis (ex.: Metasploitable2 e DVWA). O objetivo é aprender técnicas de auditoria, registrar procedimentos e propor mitigação.

Conteúdo do repositório
- README.md — este arquivo (visão geral e instruções).
- docs/report.md — relatório de testes com evidências e observações.
- scripts/run-attacks.sh — script exemplo com comandos (modifique antes de usar).
- wordlists/common-passwords.txt — pequena wordlist de exemplo.
- wordlists/smb-users.txt — lista de usuários de exemplo para password spraying.
- .gitignore — entradas úteis (ex.: imagens locais).

Aviso de ética e legalidade
Execute estes testes somente em ambientes sob seu controle (laboratório, VMs que você instalou). Testes não autorizados em sistemas alheios são ilegais e antiéticos.

Pré-requisitos
- Máquina host com VirtualBox ou similar.
- Imagens: Kali Linux (mais recente) e Metasploitable2 (ou DVWA em uma VM LAMP).
- Rede: configurar as duas VMs em rede interna/host-only para isolar o laboratório.
- Ferramentas: Medusa (instalada no Kali), Hydra (opcional para formulários web), Nmap, Burp Suite (opcional).

Arquitetura sugerida
- Kali Linux — atacante (ex.: 192.168.56.100)
- Metasploitable2 / DVWA — alvo (ex.: 192.168.56.101)
Use modo Host-only ou Internal Network no VirtualBox para comunicação entre VMs sem exposição externa.

Procedimentos principais (exemplos)
1) Reconhecimento
- Descobrir serviços: nmap -sS -sV -O 192.168.56.101
- Identificar serviços FTP(21), SSH(22), SMB(445), HTTP(80) etc.

2) Força bruta em FTP (Medusa)
- Sintaxe geral:
  medusa -h <ALVO> -u <USUARIO> -P <WORDLIST> -M ftp
- Exemplo:
  medusa -h 192.168.56.101 -u msfadmin -P wordlists/common-passwords.txt -M ftp

3) Password spraying / brute force SMB (Medusa)
- Exploração por lista de usuários e senha comum:
  medusa -h 192.168.56.101 -U wordlists/smb-users.txt -P wordlists/common-passwords.txt -M smbnt
- Observação: limite tentativas, respeite bloqueio de conta e detecção.

4) Teste de formulário web (DVWA)
- Muitos preferem Hydra ou Burp intruder para formularios:
  hydra -l admin -P wordlists/common-passwords.txt 192.168.56.101 http-form-post "/dvwa/login.php:username=^USER^&password=^PASS^:Login failed"
- Também é possível usar Burp para automatizar payloads e analisar respostas.

Validação de sucesso
- FTP: logins bem sucedidos são exibidos no output do Medusa (usuário/senha).
- SMB: acesso à lista de shares ou autenticação aceita.
- Web: redirecionamento, ausência da mensagem de falha ou conteúdo protegido acessível.
Sempre registre timestamps e capturas de tela em /images.

Mitigações recomendadas
- Políticas de senha fortes (comprimento, complexidade).
- Bloqueio de conta temporário após N tentativas.
- Rate-limiting e detecção de anomalias (SIEM).
- Proteções adicionais: MFA, logs centralizados e alertas.
- Para serviços SMB: desativar SMBv1, aplicar patches e mínimos privilégios.

Referências úteis
- Kali Linux (site oficial)
- Medusa (documentação)
- DVWA — Damn Vulnerable Web Application
- Nmap — manual

5) Resultados e Aprendizados
Durante este projeto, aprendi:

✔ Como configurar redes internas no VirtualBox
✔ Como identificar serviços vulneráveis com Nmap
✔ Como o Medusa automatiza ataques massivos
✔ Como bruteforce funciona na prática
✔ Importância do hardening de sistemas
✔ Como documentar ataques de forma profissional

Licença / Observações finais
Conteúdo de aprendizado; adapte wordlists e scripts para seu laboratório. Não use contra sistemas de terceiros sem autorização.
