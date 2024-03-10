incsrc "def.asm"
    
freecode
    
speed_cycle:
    ; cycles official snes mouse speed setting.
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
    lda $421a               ; mouse here?
    sta !mouse_raw+2        ;
    and #$0f                ;
    cmp #$01                ;
    sta !mouse_plugged      ;
    beq .plugged            ; if not,
    stz !mouse_raw+0        ; clear raw mouse data,
    stz !mouse_raw+1        ;
    stz !mouse_x_clean      ;
    stz !mouse_y_clean      ;
    bra .notPlugged         ; skip polling and speed cleaning.
    
    .plugged:
    
    ldx #$00                ; get mouse input.
    --                      ;
    ldy #$08                ;
    -                       ;
    lda $4017               ;
    lsr                     ;
    rol !mouse_raw,x        ;
    dey                     ;
    bne -                   ;
    inx                     ;
    cpx #$02                ;
    bne --                  ;
        
    lda !mouse_raw+0        ; clean y speed.
    bpl +                   ;
    eor #$7f                ;
    inc                     ;
    +                       ;
    sta !mouse_y_clean      ;
        
    lda !mouse_raw+1        ; clean x speed.
    bpl +                   ;
    eor #$7f                ;
    inc                     ;
    +                       ;
    sta !mouse_x_clean      ;
    
    .notPlugged:
    
    lda !mouse_raw+2        ; store changes.
    eor !mouse_raw_prev     ;
    sta !mouse_raw_prev     ;
    and !mouse_raw+2        ; set up states.
    sta !mouse_up           ;
    lda !mouse_raw+2        ; set down states.
    eor #$ff                ;
    and !mouse_raw_prev     ;
    sta !mouse_down         ;
    
    lda !mouse_up           ; right click?
    and #$80                ;
    beq +                   ; if yes,
    lda.b #!mouse_cc_time   ; set ccr timer,
    sta !mouse_cc_r_timer   ; 
    inc !mouse_cc_r         ; and increase ccr counter.
    +                       ;
    
    lda !mouse_up           ; left click?
    and #$40                ;
    beq +                   ; if yes,
    lda.b #!mouse_cc_time   ; set ccr timer,
    sta !mouse_cc_l_timer   ;
    inc !mouse_cc_l         ; and increase ccl counter.
    +                       ;
    
    lda !mouse_cc_l_timer   ; ccl timer zero?
    bne +                   ; if yes,
    stz !mouse_cc_l         ; clear ccl.
    bra ++                  ;
    +                       ; else,
    dec !mouse_cc_l_timer   ; decrement ccl timer.
    ++                      ;
    
    lda !mouse_cc_r_timer   ; ccr timer zero?
    bne +                   ; if yes,
    stz !mouse_cc_r         ; clear ccr.
    bra ++                  ;
    +                       ; else,
    dec !mouse_cc_r_timer   ; decrement ccr timer.
    ++                      ;
    
    lda !mouse_raw+2        ; update previous frame data.
    sta !mouse_raw_prev     ;

    rtl