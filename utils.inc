segment .data
    lf equ 0xA ; Quebra de linha \n
    SYS_CALL equ 0x80 ; Envia a informação para o kernel (LINUX, em outro SO é outra instrução)
    NULL equ 0x0 ; Caractere nulo

    ; EAX
    SYS_EXIT equ 0x1 ; Código chamado para finalizar a execução
    SYS_READ equ 0x3 ; Código para leitura de valores
    SYS_WRITE equ 0x4 ; Cógido para a escrita de valores

    ; EBX
    SYS_RETURN equ 0x1 ; Código para sair da execução do software
    RET_EXIT equ 0x0 ; Código de retorno em caso de sucesso ; return 0
    STD_IN equ 0x0 ; Entrada padrão
    STD_OUT equ 0x1 ; Saida padrão 