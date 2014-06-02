(clear)
(reset-camera)

(start-audio "system:capture_1" 512 44100)

(midiin-open 1)

(gain 0.5)

(ambient 0)
(blur 0)
(desiredfps 60)

(define base_dir "/home/mrk25/Desktop")

(define Scale 10)
(define RotX -60)
(define RotY 60)
(define RotZ -60)

;Define Initial colors
(define RedLightness 0.25)
(define GreenLightness 0.25)
(define BlueLightness 0.25)


(define max_clients 23)
(define launchClient 0)

(define clients (make-vector 0))
(define tmpClients (make-vector 0))

(define actualClients 0)
(define iClients (make-vector 0))
(define j 0)

(define countClients 0)
(define iteraClients (make-vector 0))
(define k 0)


;(define Psystems (build-vector 8 add1))

(define psys0 (with-state (build-particles 720)))
(define psys1 (with-state (build-particles 720)))
(define psys2 (with-state (build-particles 720)))
(define psys3 (with-state (build-particles 720)))
(define psys4 (with-state (build-particles 720)))
(define psys5 (with-state (build-particles 720)))
(define psys6 (with-state (build-particles 720)))
(define psys7 (with-state (build-particles 720)))
(define psys8 (with-state (build-particles 720)))
(define psys9 (with-state (build-particles 720)))
(define psys10 (with-state (build-particles 720)))
(define psys11 (with-state (build-particles 720)))
(define psys12 (with-state (build-particles 720)))
(define psys13 (with-state (build-particles 720)))
(define psys14 (with-state (build-particles 720)))
(define psys15 (with-state (build-particles 720)))
(define psys16 (with-state (build-particles 720)))
(define psys17 (with-state (build-particles 720)))
(define psys18 (with-state (build-particles 720)))
(define psys19 (with-state (build-particles 720)))
(define psys20 (with-state (build-particles 720)))
(define psys21 (with-state (build-particles 720)))
(define psys22 (with-state (build-particles 720)))
(define psys23 (with-state (build-particles 720)))
;(define psys24 (with-state (build-particles 768)))
;(define psys25 (with-state (build-particles 768)))
;(define psys26 (with-state (build-particles 768)))
;(define psys27 (with-state (build-particles 768)))
;(define psys28 (with-state (build-particles 768)))
;(define psys29 (with-state (build-particles 768)))
;(define psys30 (with-state (build-particles 768)))
;(define psys31 (with-state (build-particles 768)))

(define Psystems (vector
	(vector psys0 -8 -4 (vector 0.1 0.1 0.1))
	(vector psys1 -4 0 (vector 0.1 0.1 0.1))
	(vector psys2 8 -4 (vector 0.1 0.1 0.1))
	(vector psys3 4 0 (vector 0.1 0.1 0.1))
	(vector psys4 -12 -6 (vector 0.1 0.1 0.1))
	(vector psys5 -6 0 (vector 0.1 0.1 0.1))
	(vector psys6 12 -6 (vector 0.1 0.1 0.1))
	(vector psys7 6 0 (vector 0.1 0.1 0.1))
	(vector psys8 1 1 (vector 0.1 0.1 0.1))
	(vector psys9 -1 -1 (vector 0.1 0.1 0.1))
	(vector psys10 2 2 (vector 0.1 0.1 0.1))
	(vector psys11 -2 -2 (vector 0.1 0.1 0.1))
	(vector psys12 3 3 (vector 0.1 0.1 0.1))
	(vector psys13 -3 -3 (vector 0.1 0.1 0.1))
	(vector psys14 4 4 (vector 0.1 0.1 0.1))
	(vector psys15 -4 -4 (vector 0.1 0.1 0.1))
	
	(vector psys16 -7 -3 (vector 0.1 0.1 0.1))
	(vector psys17 -3 -1 (vector 0.1 0.1 0.1))
	(vector psys18 7 -2 (vector 0.1 0.1 0.1))
	(vector psys19 3 -1 (vector 0.1 0.1 0.1))
	(vector psys20 -11 -5 (vector 0.1 0.1 0.1))
	(vector psys21 -5 -1 (vector 0.1 0.1 0.1))
	(vector psys22 11 -5 (vector 0.1 0.1 0.1))
	(vector psys23 5 -1 (vector 0.1 0.1 0.1))
	;(vector psys24 0 0 (vector 0.1 0.1 0.1))
	;(vector psys25 -2 -2 (vector 0.1 0.1 0.1))
	;(vector psys26 3 -4 (vector 0.1 0.1 0.1))
	;(vector psys27 -4 -4 (vector 0.1 0.1 0.1))
	;(vector psys28 -3 3 (vector 0.1 0.1 0.1))
	;(vector psys29 3 -3 (vector 0.1 0.1 0.1))
	;(vector psys30 -4 4 (vector 0.1 0.1 0.1))
	;(vector psys31 4 -4 (vector 0.1 0.1 0.1))
	
	))


; util func to return a random vector
(define (rndvec)
    (vsub (vector (flxrnd) (flxrnd) (flxrnd)) 
        (vector 0.5 0.5 0.5)))
        
; util function to return a random value
(define (rndval)
    (- (flxrnd) 
        0.5))


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
	    (pdata-map! (lambda (s) (vector .2 .2 .2)) "s")
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
        
        (pdata-map! (lambda (s) (vector .2 .2 .2)) "s")
        
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



(define (pulse base_dir pulseRedLightness pulseGreenLightness pulseBlueLightness pulseScale pulseRotX pulseRotY pulseRotZ)
    
     (when (key-pressed "1")
     	(handUp (* 12 (rndval)) (* 12 (rndval)) (rndval) (rndval) (rndval))
     )
    
     (for ([i Psystems])
		;(translate (vector (vector-ref i 1) 0 (vector-ref i 2)))
		
		
		(with-state
			(translate (vector (vector-ref i 1) -10 (vector-ref i 2)))
			(rotate (vector 0 (* 1 (gh 0) pulseRotY) 0))
			(with-primitive (vector-ref i 0)
			
				;(pdata-map! (lambda (c) (vmul (vector (gh 0) (gh 4) (gh 8)) 0.1)) "c")
				
				(pdata-map! (lambda (c) (vmul (vector (vector-ref (vector-ref i 3) 0) (vector-ref (vector-ref i 3) 1) (vector-ref (vector-ref i 3) 2)) (gh 0))) "c")
				
				(rotate (vector 0 (* 0.01 (gh 0) pulseRotY) 0))
				(pdata-map! 
				(lambda (vel) (vadd vel (vector 0 (* 0.000001 (gh 0) pulseScale) 0)))
				"vel")
				
				(pdata-map! vadd "p" "vel")
				
				(draw-instance (vector-ref i 0))
			)
			
			
			
		)
		
		
		
		;(begin (display i))

		
	)
    
)









;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(every-frame
    ;(begin (display (midi-peek)) (newline))
    
    (pulse base_dir RedLightness GreenLightness BlueLightness Scale RotX RotY RotZ)
    ;(mappingSchema base_dir RedLightness GreenLightness BlueLightness Scale RotX RotY RotZ)
)









