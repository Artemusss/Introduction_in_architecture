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
    li a3, 0                # ??? branch #3, ??????? = TAKEN; ???????? 4 ????? ? ????? 56..59
    li a4, 1                # ??? branch #4, ??????? = NOT TAKEN; ????? 60..63
    nop                     # ????? 64..67
    nop                     # 68..71
    nop                     # 72..75
    nop                     # 76..79

    beq a3, zero, magic_br_3   # branch #3, ????? 80..83  ? (80>>2)=20, 20 mod8 = 4
magic_br_3:
    nop                     # ????? 84..87
    nop                     # 88..91
    nop                     # 92..95
    nop                     # 96..99
    nop                     # 100..103
    nop                     # 104..107
    nop                     # 108..111

    beq a4, zero, magic_br_4   # branch #4, ????? 112..115 ? (112>>2)=28, 28 mod8 = 4
    nop                     # (???????????, ????? 116..119)
magic_br_4:
# **********************



    addi    a1, a1, 1
    bne     a1, t0, loop
