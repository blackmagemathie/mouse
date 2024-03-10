; more info at:
; https://www.nesdev.org/wiki/Super_NES_Mouse
; ----------------
!mouse_raw          = $3426 ; raw mouse data, current frame.
!mouse_raw_prev     = $3429 ; last byte of raw mouse data, previous frame.
!mouse_up           = $342a ; buttons that just went up.
!mouse_down         = $342b ;                        down.
!mouse_x_clean      = $342c ; sign-corrected x speed.
!mouse_y_clean      = $342d ;                y speed.
!mouse_cc_l_timer   = $342e ; consecutive clicks timer, left.
!mouse_cc_r_timer   = $342f ;                           right.
!mouse_cc_l         = $3430 ; consecutive clicks, left.
!mouse_cc_r         = $3431 ;                     right.
!mouse_cc_time      = $20   ; max time between consecutive clicks.
!mouse_plugged      = $3432 ; format : 0000000d
                            ; d = if set, mouse detected.