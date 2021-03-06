;(set-screen-size (vector 1024 768))

(clear)
(reset-camera)

(start-audio "system:capture_1" 512 44100)

;(midiin-open 1)

(gain 0.5)

(ambient 0)
(blur 0)
(desiredfps 60)

(define base_dir "/home/mrk25/Desktop")

(define Scale 10)
(define RotX 0)
(define RotY 0)
(define RotZ 0)

(define momX 0.6)
(define momY 0.6)
(define momZ 0.6)



;Define Initial colors
(define RedLightness 0.25)
(define GreenLightness 0.25)
(define BlueLightness 0.25)

(define numParticles 540)

(define max_clients 32)
(define launchClient 0)

(define clients (make-vector 0))
(define tmpClients (make-vector 0))

(define actualClients 0)
(define iClients (make-vector 0))
(define j 0)

(define countClients 0)
(define iteraClients (make-vector 0))
(define k 0)

; util func to return a random vector
(define (rndvec)
    (vsub (vector (flxrnd) (flxrnd) (flxrnd)) 
        (vector 0.5 0.5 0.5)))
        
; util function to return a random value
(define (rndval)
    (- (flxrnd) 
        0.5))


(define Psystems (make-vector max_clients))

(for ([i (in-range (vector-length Psystems))])
  (vector-set! Psystems i (vector (with-state (build-particles numParticles)) (* 10 (rndval)) (* 10 (rndval)) (rndvec)))
)


;(define prtclSys (with-state (build-particles 4096)))
(for ([i Psystems])
	(with-primitive (vector-ref i 0)

	    (translate (vector 0 -20 0))
	    
	    ; add the velocity pdata 
	    (pdata-add "vel" "v")
	    ; init all the velocities
	    ;(pdata-map! (lambda (vel) (vmul (rndvec) 1)) "vel")
	    (pdata-map! (lambda (vel) (vmul (vector (* 0.001 (rndval)) (rndval) (* 0.001 (rndval))) 4)) "vel")
	    
	    ;init particles size
	    (pdata-map! (lambda (s) (vector .3 .3 .3)) "s")
	    ; init all the colours
	    ;(pdata-map! (lambda (c) (vector 0 0 0)) "c")
	    
	)
	(with-primitive (vector-ref i 0) (hide 1))

)


(define (attachClient coords)

        (set! actualClients (vector-length clients))
        (set! iClients (make-vector actualClients))
        
        (set! tmpClients clients)
        
        (set! clients (make-vector (+ 1 actualClients))) 
        (set! j 0)
        
        (for ([i iClients])
            
            (vector-set! clients j (vector (vector-ref (vector-ref tmpClients j) 0) (vector-ref (vector-ref tmpClients j) 1)))
            
            (set! j (+ 1 j))

        )
        
        (vector-set! clients actualClients coords)

)






; Color switcher
(define (colorSchema Red Green Blue)

    (set! RedLightness Red)
    (set! GreenLightness Green)
    (set! BlueLightness Blue)
)

; Transformations intensity
(define (transformSchema S X Y Z)

    (set! Scale S)
    (set! RotX X)
    (set! RotY Y)
    (set! RotZ Z)
)



(define (handUp dX dY R G B)
	(if (>= launchClient max_clients)
		(set! launchClient 0)
		(set! launchClient (+ 1 launchClient))
	)
	
	(vector-set! Psystems launchClient (vector (vector-ref (vector-ref Psystems launchClient) 0) dX dY (vector R G B)))
	(particlesReset (vector-ref (vector-ref Psystems launchClient) 0))
	
)

;particle sysyem reset
(define (particlesReset System)
    (with-primitive System
        
        (pdata-map! (lambda (s) (vector .3 .3 .3)) "s")
        
        (pdata-map! (lambda (p) (vector 0 0 0)) "p")
        (pdata-map! (lambda (vel) (vector 0 0 0)) "vel")
        ;(pdata-map! (lambda (vel) (pdata-get "System" 0)) "vel")
        
    )
    

    (with-primitive System (pdata-map! (lambda (vel) (vmul (vector (* 0.001 (rndval)) (rndval) (* 0.001 (rndval))) 4)) "vel") )

)

(define (psysVelReset System)
    (with-primitive System
        (pdata-map! (lambda (vel) (vmul (rndvec) 2)) "vel")
        ;(pdata-map! (lambda (vel) (vmul (vector (* 0.001 (rndval)) (rndval) (* 0.001 (rndval))) 4)) "vel")   
    )
    
)

(define accumRot (vector 0 0 0))
(define (accumRotAdd)
	(set! accumRot (vadd accumRot (vector 0 (* (gh 0) momY) 0)))
)

(define (pulse base_dir pulseRedLightness pulseGreenLightness pulseBlueLightness pulseScale pulseRotX pulseRotY pulseRotZ)
    
     (accumRotAdd)
     (rotate (vector RotX RotY RotZ))
     
     ; emulate sensor trigger with random values
     (when (key-pressed "1")
     	(handUp (* 10 (rndval)) (* 10 (rndval)) (rndval) (rndval) (rndval))
     )
     
     ; include sensor triggers evaluation code
     (load "triggers.scm")
     
     
    
     (for ([i Psystems])
		;(translate (vector (vector-ref i 1) 0 (vector-ref i 2)))
		
		
		(with-state
			(translate (vector (vector-ref i 1) -10 (vector-ref i 2)))
			
			;(begin (display accumRot))
			(rotate accumRot)
			;(rotate (vector 0 (* 1 (gh 0) pulseRotY) 0))
			(with-primitive (vector-ref i 0)
			
				;(pdata-map! (lambda (c) (vmul (vector (gh 0) (gh 4) (gh 8)) 0.1)) "c")
				
				(pdata-map! (lambda (c) (vmul (vector (vector-ref (vector-ref i 3) 0) (vector-ref (vector-ref i 3) 1) (vector-ref (vector-ref i 3) 2)) (gh 0))) "c")
				
				;(rotate (vector 0 (* 0.01 (gh 0) pulseRotY) 0))
				(pdata-map! 
				(lambda (vel) (vadd vel (vector 0 (* 0.000001 (gh 0) pulseScale) 0)))
				"vel")
				
				(pdata-map! vadd "p" "vel")
				
				(draw-instance (vector-ref i 0))
			)
			
			
			
		)

		
	)
    
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(every-frame
    ;(begin (display (midi-peek)) (newline))
    (pulse base_dir RedLightness GreenLightness BlueLightness Scale RotX RotY RotZ)
)
