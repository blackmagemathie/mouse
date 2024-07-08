; more info at:
; https://www.nesdev.org/wiki/Super_NES_Mouse

; direct page
    !mouse_dp = $3400
    ; not to self : wrapper takes 33 cycles
    
; raw data
    !mouse_raw      = $3426 ; raw data, current frame.
    !mouse_raw_prev = $3429 ;           previous frame last byte.
    
; up/down states
    !mouse_up   = $342a ; buttons that went up.
    !mouse_down = $342b ;                   down.
    
; speed
    !mouse_x_clean = $342c ; sign-corrected speed, x.
    !mouse_y_clean = $342d ;                       y.
    
; consecutive clicks
    !mouse_cc_l_timer = $342e ; timer, left.
    !mouse_cc_r_timer = $342f ;        right.
    !mouse_cc_l       = $3430 ; clicks, left.
    !mouse_cc_r       = $3431 ;         right.
    !mouse_cc_time    = $20   ; max time between clicks.
    
; misc
    !mouse_plugged = $3432 ; $01 = mouse found; $00 = not found.