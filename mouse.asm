incsrc "def/global.asm"
incsrc "def/local.asm"

freecode

speed_cycle:
    ; cycles original snes mouse speed setting.
    ; ----------------
    ldy #1
    sty $4016
    lda $4017
    dey
    sty $4016
    rtl

poll:
    ; reads mouse data from controller port 2.
    ; ----------------
    php
    rep #$20
    tdc
    pha
    lda.w #!mouse_dp
    tcd
    sep #$30
    
    ; plugged?
    lda $421a
    sta.b !rc+2
    and #$0f
    cmp #$01
    sta.b !mp
    beq +
    stz.b !rc+0
    stz.b !rc+1
    stz.b !sx
    stz.b !sy
    bra ++
    +
    
    ; get raw
    ldx #$00
    --
    ldy #$08
    -
    lda $4017
    lsr
    rol.b !rc,x
    dey
    bne -
    inx
    cpx #$02
    bne --
    
    ; clean speed y
    lda.b !rc+0
    bpl +
    eor #$7f
    inc
    +
    sta.b !sy
    
    ; clean speed x
    lda.b !rc+1
    bpl +
    eor #$7f
    inc
    +
    sta.b !sx

    ++

    ; set u/d states
    lda.b !rc+2
    eor.b !rp
    sta.b !rp
    and.b !rc+2
    sta.b !bu
    lda.b !rc+2
    eor #$ff
    and.b !rp
    sta.b !bd

    ; cc right
    lda.b !bu
    and #$80
    beq +
    lda.b #!cm
    sta.b !crt
    inc.b !cr
    +
    lda.b !crt
    bne +
    stz.b !cr
    bra ++
    +
    dec.b !crt
    ++
    
    ; cc left
    lda.b !bu
    and #$40
    beq +
    lda.b #!cm
    sta.b !clt
    inc.b !cl
    +
    lda.b !clt
    bne +
    stz.b !cl
    bra ++
    +
    dec.b !clt
    ++
    
    ; update raw prev
    lda.b !rc+2
    sta.b !rp
    
    rep #$20
    pla
    tcd
    plp
    rtl