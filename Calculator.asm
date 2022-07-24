%include 'utils.inc'

section .data
   ; Menu
   MensagemBemVindo db 'Sejam bem vindo a calculadora Assembly - github.com/daniel-kenobi', lf
   TamMensagemBemVindo equ $ - MensagemBemVindo

   MensagemMenu db 'Escolha uma operação: 1 - Soma, 2 - Subtração, 3 - Multiplicação, 4 - Divisão, 0 - Sair', lf
   TamMensagemMenu equ $ - MensagemMenu

   MensagemEscolha db 'Opcao: '
   TamMensagemEscolha equ $ - MensagemEscolha

   MensagemEntreComNumero db 'Entre com o '
   TamMensagemEntreComNumero equ $ - MensagemEntreComNumero

   ; Soma
   MensagemPrimeiroNumero db 'primeiro numero: '
   TamMensagemPrimeiroNumero equ $ - MensagemPrimeiroNumero

   MensagemSegundoNumero db 'segundo numero: '
   TamMensagemSegundoNumero equ $ - MensagemSegundoNumero   

   ; Divisão
   MensagemDivisor db 'divisor: '
   TamMensagemDivisor equ $ - MensagemDivisor
   
   MensagemDividendo db 'dividendo :'
   TamMensagemDividendo equ $ - MensagemDividendo

   ; Multiplicação
   MensagemMultiplicador db 'multiplicador: '
   TamMensagemMultiplicador equ $ - MensagemMultiplicador
   
   MensagemMultiplicando db 'multiplicando: '
   TamMensagemMultiplicando equ $ - MensagemMultiplicando
  
   ; Saída
   MensagemResultado db 'Resultado: '
   TamMensagemResultado equ $ - MensagemResultado

   MensagemOpcaoInvalida db 'Opcao invalida. '
   TamMensagemOpcaoInvalida equ $ - MensagemOpcaoInvalida

   MensagemFinalizacao db 'Finzalizando o processo.', lf
   TamMensagemFinalizacao equ $ - MensagemFinalizacao

section .bss
    num1 resq 1
    num2 resq 1
    op resq 1
    result resq 1

section .text

global _start

_start:
    ; Bem vindo
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, MensagemBemVindo
    mov edx, TamMensagemBemVindo
    int SYS_CALL

    ; Menu
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, MensagemMenu
    mov edx, TamMensagemMenu
    int SYS_CALL

    ; Mensagem Opcao
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, MensagemEscolha
    mov edx, TamMensagemEscolha
    int SYS_CALL

    ; Leitura do numero
    mov eax, SYS_READ
    mov ebx, STD_IN
    mov ecx, op
    mov edx, 0xA
    int SYS_CALL
    
    mov edx, op
    call StringToInt

    ; Comparo o numero de entrada para ver se é soma
    cmp eax, 1
    call SomaDoisNumeros
    jmp ImprimeResultado

    ; Comparo o numero de entrada para ver se é subtração
    cmp eax, 2
    je SubtraiDoisNumeros

    ; Comparo o numero de entrada para ver se é multiplicação
    cmp eax, 3
    je MultiplicaDoisNumeros

    ; Comparo o numero de entrada para ver se é divisão
    cmp eax, 4
    je DivideDoisNumeros

    ; Compara o numeor de entrada para ver se é opcode de saida
    cmp eax, 0x0
    je Saida

    ; Caso não seja nenhum saio
    jmp SaidaNumeroInvalido

SomaDoisNumeros:
    call ExibeMensagemInicial

    ; Exibe segunda mensagem ''
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, MensagemPrimeiroNumero
    mov edx, TamMensagemPrimeiroNumero
    int SYS_CALL

    call LerNumero1

    ; Exibe terceira mensagem ''
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, MensagemSegundoNumero
    mov edx, TamMensagemSegundoNumero
    int SYS_CALL

    call LerNumero2

    mov eax, num1
    mov ebx, num2

    add eax, ebx
    mov [result], eax
    ret

LerNumero1:
    mov eax, SYS_READ
    mov ebx, STD_IN
    mov ecx, num1
    mov edx, 0xA ; Leio um numero de até 10 posições
    int SYS_CALL

    mov edx, num1
    call StringToInt
    mov [num1], eax
    ret

LerNumero2:
    mov eax, SYS_READ
    mov ebx, STD_IN
    mov ecx, num2
    mov edx, 0xA ; Leio um numero de até 10 posisções
    int SYS_CALL

    mov edx, num2
    call StringToInt
    mov [num2], eax
    ret

SubtraiDoisNumeros:
    ret

MultiplicaDoisNumeros: 
    ret

DivideDoisNumeros:
    ret

SaidaNumeroInvalido:
    mov EAX, SYS_WRITE
    mov EBX, STD_OUT
    mov ECX, MensagemOpcaoInvalida
    mov EDX, TamMensagemOpcaoInvalida
    int SYS_CALL

    mov EAX, SYS_WRITE
    mov EBX, STD_OUT
    mov ECX, MensagemFinalizacao
    mov EDX, TamMensagemFinalizacao
    int SYS_CALL

    mov EAX, SYS_EXIT
    mov EBX, SYS_RETURN
    int SYS_CALL

ExibeMensagemInicial:
    ; Exibo mensagem incial 'Entre com o'
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, MensagemEntreComNumero
    mov edx, TamMensagemEntreComNumero
    int SYS_CALL
    ret

ImprimeResultado:
    mov EAX, SYS_WRITE
    mov EBX, STD_OUT
    mov ECX, MensagemResultado
    mov EDX, TamMensagemResultado
    int SYS_CALL
    
    mov EAX, SYS_WRITE
    mov EBX, STD_OUT
    mov ECX, result ; Revisar
    mov EDX, 0xF
    int SYS_CALL
    ret

Saida:
    mov EAX, SYS_WRITE
    mov EBX, STD_OUT
    mov ECX, MensagemFinalizacao
    mov EDX, TamMensagemFinalizacao
    int SYS_CALL

    mov EAX, SYS_EXIT
    mov EBX, SYS_RETURN
    int SYS_CALL

;   ESTUDAR MELHOR ----->
;   ESTUDAR MELHOR ----->
;   ESTUDAR MELHOR ----->

StringToInt:
    xor eax, eax ; zero a "result so far"
.top:
    movzx ecx, byte [edx] ; get a character
    inc edx ; ready for next one
    cmp ecx, '0' ; valid?
    jb .done
    cmp ecx, '9'
    ja .done
    sub ecx, '0' ; "convert" character to number
    imul eax, 10 ; multiply "result so far" by ten
    add eax, ecx ; add in current digit
    jmp .top ; until done
.done:
    ret