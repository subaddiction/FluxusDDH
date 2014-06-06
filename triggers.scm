;;;
;;; VJ controls
;;;

; keyboard triggers
(define RotAmp 3)

(when (key-pressed "q")
	(set! RotX (+ RotAmp RotX))
)
(when (key-pressed "w")
	(set! RotY (+ RotAmp RotY))
)
(when (key-pressed "e")
	(set! RotZ (+ RotAmp RotZ))
)

(when (key-pressed "a")
	(set! RotX (- RotX RotAmp))
)
(when (key-pressed "s")
	(set! RotY (- RotY RotAmp))
)
(when (key-pressed "d")
	(set! RotZ (- RotZ RotAmp))
)

(when (key-pressed "z")
	(set! RotX 0)
	(set! RotY 0)
	(set! RotZ 0)
)

; OSC signals



;;;
;;; SENSORS
;;;

