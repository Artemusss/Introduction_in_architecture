.text
main:
    li      t0, 10000
    li      a3, 1
    li      a4, 0
    li      a1, 0
loop:
    beq     a4, zero, magic_br_1 # branch #1
    addi    a4, a4, 0
magic_br_1:
    nop
    nop
    nop
    nop
    nop
    nop
    
    beq     a3, zero, magic_br_2 # branch #2
    addi    a3, a3, 0
magic_br_2:

# ****** ADD HERE ******
    li a3, 0
    li a4, 1
    nop
    nop
    nop
    nop

    beq a3, zero, magic_br_3
magic_br_3:
    nop
    nop
    nop
    nop
    nop
    nop
    nop

    beq a4, zero, magic_br_4
    nop
magic_br_4:
# **********************



    addi    a1, a1, 1
    bne     a1, t0, loop
