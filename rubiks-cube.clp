

(defglobal ?*move* = 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; MIDDLE LAYER done ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule R1-middle-layer-done (declare (salience 10))
	(not (Face ? ? ? ?e1 ?fixed&~Y ?e2&~?e1|~?fixed $?))
    (not (is-done middle-layer))
	=>
	(assert (is-done middle-layer))
	(printout t "Middle layer is done. " crlf)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Instanta 1.a ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule R1a-all-edge-pieces-contain-yellow 
	(not (is-done middle-layer))
	(Face ? ?back ? ?left Y ?right ? ?front ?)
	(Face-Orientation ?back-face-color B)
	(Face-Orientation ?right-face-color R)
	(Face-Orientation ?left-face-color L)
	(Face-Orientation ?front-face-color F)
	(or (test (eq ?back Y)) (Face ? Y ? ? ?back-face-color $?))
	(or (test (eq ?front Y)) (Face ? Y ? ? ?front-face-color $?))
	(or (test (eq ?right Y)) (Face ? Y ? ? ?right-face-color $?))
	(or (test (eq ?left Y)) (Face ? Y ? ? ?left-face-color $?))
	(Face ? ? ? ? ?future-front&~Y ?x&:(neq ?x ?future-front) $?) ;;;;;;;; Not sure if this is a good condition
	=>
	(printout t "All edge pieces contain Yellow. " crlf)
	(assert (must-be-front ?future-front))
	(assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* R))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* Ui))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* Ri))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* Ui))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* Fi))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* F))
	(bind ?*move* (+ ?*move* 1))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Instanta 1.b ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 1st * ;;;;;;;;;;;;

(defrule R1b1-edge-piece-on-back-face-different-color
	(not (is-done middle-layer))
	(Face ? ~Y ? ? Y $?)
	(Face ? ?edge-back&~Y ? ? ?back-face-color&~?edge-back $?)
	(Face-Orientation ?back-face-color B)
	=>
	(printout t "Adding move U."  crlf)
	(assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
)

(defrule R1b2-edge-piece-on-front-face-different-color 
	(not (is-done middle-layer))
	(Face $? Y ? ? ~Y ?)
	(Face ? ?edge-front&~Y ? ? ?front-face-color&~?edge-front $?)
	(Face-Orientation ?front-face-color F)
	=>
	(printout t "Adding move U."  crlf)
	(assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
)

(defrule R1b3-edge-piece-on-right-face-different-color 
	(not (is-done middle-layer))
	(Face $? Y ~Y ? ? ?)
	(Face ? ?edge-right&~Y ? ? ?right-face-color&~?edge-right $?)
	(Face-Orientation ?right-face-color R)
	=>
	(printout t "Adding move U."  crlf)
	(assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
)

(defrule R1b4-edge-piece-on-left-face-different-color
	(not (is-done middle-layer))
	(Face ? ? ? ~Y Y $?)
	(Face ? ?edge-left&~Y ? ? ?left-face-color&~?edge-left $?)
	(Face-Orientation ?left-face-color L)
	=>
	(printout t "Adding move U."  crlf)
	(assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 2nd * ;;;;;;;;;;;;;;

(defrule R1b5-edge-piece-on-back-face-same-color (declare (salience 8))
	(not (is-done middle-layer))
	(Face ? ~Y ? ? Y $?)
	(Face ? ?edge-back&~Y ? ? ?edge-back $?)
	(Face-Orientation ?edge-back B)
	=>
	(printout t "Adding reorientation target. Current BACK Face will be Front Face."  crlf)
	(assert (must-be-front ?edge-back))
)

(defrule R1b6-edge-piece-on-left-face-same-color (declare (salience 8))
	(not (is-done middle-layer))
	(Face ? ? ? ~Y Y $?)
	(Face ? ?edge-left&~Y ? ? ?edge-left $?)
	(Face-Orientation ?edge-left L)
	=>
	(printout t "Adding reorientation target. Current LEFT Face will be Front Face."  crlf)
	(assert (must-be-front ?edge-left))
)

(defrule R1b7-edge-piece-on-right-face-same-color (declare (salience 8))
	(not (is-done middle-layer))
	(Face $? Y ~Y ? ? ?)
	(Face ? ?edge-right&~Y ? ? ?edge-right $?)
	(Face-Orientation ?edge-right R)
	=>
	(printout t "Adding reorientation target. Current RIGHT Face will be Front Face."  crlf)
	(assert (must-be-front ?edge-right))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 3rd * ;;;;;;;;;;;;;;

(defrule R1b8-edge-piece-on-front-face-same-color-move-right (declare (salience 9))
	(not (is-done middle-layer))
	(Face ? ?edge-front&~Y ? ? ?edge-front $?)
	(Face-Orientation ?edge-front F)
	(Face-Orientation ?right-face-color R)
	(Face $? Y ? ? ?right-face-color&~Y ?)
	=>
	(printout t "MOVE FRONT-EDGE TO THE RiGHT. " crlf)
	(assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* R))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* Ui))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* Ri))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* Ui))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* Fi))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* F))
	(bind ?*move* (+ ?*move* 1))
	
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 4th * ;;;;;;;;;;;;;;

(defrule R1b9-edge-piece-on-front-face-same-color-move-left (declare (salience 9))
	(not (is-done middle-layer))
	(Face ? ?edge-front&~Y ? ? ?edge-front $?)
	(Face-Orientation ?edge-front F)
	(Face-Orientation ?left-face-color L)
	(Face $? Y ? ? ?left-face-color&~Y ?)
	=>
	(printout t "MOVE FRONT-EDGE TO THE LEFT. " crlf)
	(assert (move ?*move* Ui))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* Li))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* L))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* F))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* Ui))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* Fi))
	(bind ?*move* (+ ?*move* 1))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Instanta 2 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule R2-has-cross (declare (salience 10))
    (is-done middle-layer)
    (Face ? Y ? Y Y Y ? Y ?)
    (not (has-cross Y))
    =>
    (assert (has-cross Y))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Instanta 2.a ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Yellow line is perpendicular to F face
(defrule R2a1-yellow-line-perpendicular-to-front-face
	(is-done middle-layer)
    (not (has-cross Y))
	(Face ? Y ? ? Y ? ? Y ?)
    (Face-Orientation ?color R)
	=>
	(assert (must-be-front ?color))
)

; Yellow line is parallel to F face
(defrule R2a2-yellow-line-parallel-to-front-face
	(is-done middle-layer)
    (not (has-cross Y))
	(Face ? ? ? Y Y Y ? ? ?)
	=>
	(printout t "Adding moves for when there is yellow line. " crlf)
	(assert (move ?*move* F))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* R))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* Ri))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* Ui))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* Fi))
	(bind ?*move* (+ ?*move* 1))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Instanta 2.b ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defrule R2b1-no-yellow-line-L-rotate-Ui (declare (salience 8))
    (is-done middle-layer)
    (not (has-cross Y))
	(not (Face ? Y ? ? Y ? ? Y ?))
    (not (Face ? ? ? Y Y Y ? ? ?)) 
    (Face ? Y ? ? Y Y ? ? ?)
    =>
    (printout t "Adding move Reorienting yellow L. " crlf)
    (assert (move ?*move* Ui))
	(bind ?*move* (+ ?*move* 1))
) 

(defrule R2b2-no-yellow-line-L-rotate-U (declare (salience 8))
    (is-done middle-layer)
    (not (has-cross Y))
	(not (Face ? Y ? ? Y ? ? Y ?))
    (not (Face ? ? ? Y Y Y ? ? ?))  
    (Face ? ? ? Y Y ? ? Y ?)
    =>
    (printout t "Adding move Reorienting yellow L. " crlf)
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
) 

(defrule R2b3-no-yellow-line-L-rotate-U2 (declare (salience 8))
    (is-done middle-layer)
    (not (has-cross Y))
	(not (Face ? Y ? ? Y ? ? Y ?))
    (not (Face ? ? ? Y Y Y ? ? ?))  
    (Face ? ? ? ? Y Y ? Y ?)
    =>
    (printout t "Adding move Reorienting yellow L. " crlf)
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
) 

(defrule R2b4-no-yellow-line-L-is-good (declare (salience 9))
    (is-done middle-layer)
    (not (has-cross Y))
	(not (Face ? Y ? ? Y ? ? Y ?))
    (not (Face ? ? ? Y Y Y ? ? ?))   
    =>
    (printout t "Adding moves for when there is NO yellow line. " crlf)
	(assert (move ?*move* F))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* R))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* Ui))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* Ri))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* Fi))
	(bind ?*move* (+ ?*move* 1))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Instanta 3 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule R3-yellow-face-done (declare (salience 10))
    (has-cross Y)
    (Face Y Y Y Y Y Y Y Y Y)
    (not (is-done Y))
    =>
    (assert (is-done Y))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Instanta 3.a ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule R3a1-no-yellow-corner-and-yellow-square-on-back-face
	(has-cross Y)
    (not (is-done Y))
    (Face ~Y ? ~Y ? Y ? ~Y ? ~Y)
    (Face ? ? Y ? ?back-face-color $?)
    (Face-Orientation ?back-face-color B)
    =>
    (assert (move ?*move* Ui))
	(bind ?*move* (+ ?*move* 1))
)

(defrule R3a2-no-yellow-corner-and-yellow-square-on-front-face
	(has-cross Y)
    (not (is-done Y))
    (Face ~Y ? ~Y ? Y ? ~Y ? ~Y)
    (Face ? ? Y ? ?front-face-color $?)
    (Face-Orientation ?front-face-color F)
    =>
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
)

(defrule R3a3-no-yellow-corner-and-yellow-square-on-right-face
	(has-cross Y)
    (not (is-done Y))
    (Face ~Y ? ~Y ? Y ? ~Y ? ~Y)
    (Face ? ? Y ? ?front-face-color $?)
    (Face-Orientation ?front-face-color R)
    =>
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
)

(defrule R3a4-no-yellow-corner-and-yellow-square-on-LEFT-face (declare (salience 9))
	(has-cross Y)
    (not (is-done Y))
    (Face ~Y ? ~Y ? Y ? ~Y ? ~Y)
    (Face ? ? Y ? ?left-face-color $?)
    (Face-Orientation ?left-face-color L)
    =>
    (assert (move ?*move* R))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Ri))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* R))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Ri))
	(bind ?*move* (+ ?*move* 1))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Instanta 3.b ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule R3b1-two-yellow-corners-and-yellow-square-on-back-face
	(has-cross Y)
    (not (is-done Y))
	(or
		(Face Y ? Y ? Y ? ~Y ? ~Y)
		(Face Y ? ~Y ? Y ? Y ? ~Y)
		(Face ~Y ? Y ? Y ? ~Y ? Y)
		(Face ~Y ? Y ? Y ? Y ? ~Y)
		(Face ~Y ? ~Y ? Y ? Y ? Y)
		(Face Y ? ~Y ? Y ? ~Y ? Y)
	)
    (Face Y ? ? ? ?back-face-color $?)
    (Face-Orientation ?back-face-color B)
    =>
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
)

(defrule R3b2-two-yellow-corners-and-yellow-square-on-left-face
	(has-cross Y)
    (not (is-done Y))
	(or
		(Face Y ? Y ? Y ? ~Y ? ~Y)
		(Face Y ? ~Y ? Y ? Y ? ~Y)
		(Face ~Y ? Y ? Y ? ~Y ? Y)
		(Face ~Y ? Y ? Y ? Y ? ~Y)
		(Face ~Y ? ~Y ? Y ? Y ? Y)
		(Face Y ? ~Y ? Y ? ~Y ? Y)
	)
    (Face Y ? ? ? ?left-face-color $?)
    (Face-Orientation ?left-face-color L)
    =>
    (assert (move ?*move* Ui))
	(bind ?*move* (+ ?*move* 1))
)

(defrule R3b3-two-yellow-corners-and-yellow-square-on-right-face
	(has-cross Y)
    (not (is-done Y))
	(or
		(Face Y ? Y ? Y ? ~Y ? ~Y)
		(Face Y ? ~Y ? Y ? Y ? ~Y)
		(Face ~Y ? Y ? Y ? ~Y ? Y)
		(Face ~Y ? Y ? Y ? Y ? ~Y)
		(Face ~Y ? ~Y ? Y ? Y ? Y)
		(Face Y ? ~Y ? Y ? ~Y ? Y)
	)
    (Face Y ? ? ? ?right-face-color $?)
    (Face-Orientation ?right-face-color R)
    =>
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
)

(defrule R3b4-two-yellow-corners-and-yellow-square-on-FRONT-face (declare (salience 9))
	(has-cross Y)
    (not (is-done Y))
	(or
		(Face Y ? Y ? Y ? ~Y ? ~Y)
		(Face Y ? ~Y ? Y ? Y ? ~Y)
		(Face ~Y ? Y ? Y ? ~Y ? Y)
		(Face ~Y ? Y ? Y ? Y ? ~Y)
		(Face ~Y ? ~Y ? Y ? Y ? Y)
		(Face Y ? ~Y ? Y ? ~Y ? Y)
	)
    (Face Y ? ? ? ?front-face-color $?)
    (Face-Orientation ?front-face-color F)
    =>
    (assert (move ?*move* R))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Ri))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* R))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Ri))
	(bind ?*move* (+ ?*move* 1))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Instanta 3.c ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule R3c1-one-yellow-corner-pos3
	(has-cross Y)
    (not (is-done Y))
	(Face ~Y Y Y Y Y Y ~Y Y ~Y)
    =>
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
)

(defrule R3c2-one-yellow-corner-pos1
	(has-cross Y)
    (not (is-done Y))
	(Face Y Y ~Y Y Y Y ~Y Y ~Y)
    =>
    (assert (move ?*move* Ui))
	(bind ?*move* (+ ?*move* 1))
)

(defrule R3c3-one-yellow-corner-pos9
	(has-cross Y)
    (not (is-done Y))
	(Face ~Y Y ~Y Y Y Y ~Y Y Y)
    =>
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
)

(defrule R3c4-one-yellow-corner-pos7-yellow-square-on-front-face
	(has-cross Y)
    (not (is-done Y))
	(Face ~Y Y ~Y Y Y Y Y Y ~Y)
	(Face ? ? Y ? ?front-face-color $?)
    (Face-Orientation ?front-face-color F)
    =>
    (assert (move ?*move* R))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Ri))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* R))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Ri))
	(bind ?*move* (+ ?*move* 1))
)

(defrule R3c5-one-yellow-corner-pos7-yellow-square-on-right-face
	(has-cross Y)
    (not (is-done Y))
	(Face ~Y Y ~Y Y Y Y Y Y ~Y)
    (Face Y ? ? ? ?right-face-color $?)
    (Face-Orientation ?right-face-color R)
    =>
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* R))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Ri))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Ui))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* R))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Ui))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Ri))
	(bind ?*move* (+ ?*move* 1))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Instanta 4 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defrule R4a-same-color-edges-not-on-good-face
	(is-done Y)
    (not (is-done cube))
	(Face ?c ? ?c ? ~?c&~Y&~W $?)
    =>
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
)

(defrule R4b-NO-same-color-edges
	(is-done Y)
    (not (is-done cube))
	(not (Face ?c ? ?c ? ~Y&~W $?))
    =>
    (assert (move ?*move* Ri))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* F))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Ri))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* B))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* B))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* R))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Fi))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Ri))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* B))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* B))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* R))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* R))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Ui))
	(bind ?*move* (+ ?*move* 1))
)


(defrule R4c1-same-color-edges-BACK-face (declare (salience 5))
	(is-done Y)
    (not (is-done cube))
	(Face ?c ? ?c ? ?c $?)
	(Face-Orientation ?c B)
    =>
    (assert (move ?*move* Ri))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* F))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Ri))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* B))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* B))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* R))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Fi))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Ri))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* B))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* B))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* R))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* R))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Ui))
	(bind ?*move* (+ ?*move* 1))
)


(defrule R4c1-same-color-edges-Right-face
	(is-done Y)
    (not (is-done cube))
	(Face ?c ? ?c ? ?c $?)
	(Face-Orientation ?c R)
	(Face-Orientation ?left-face-color L)
    =>
	(assert (must-be-front ?left-face-color))	
)

(defrule R4c1-same-color-edges-Left-face
	(is-done Y)
    (not (is-done cube))
	(Face ?c ? ?c ? ?c $?)
	(Face-Orientation ?c L)
	(Face-Orientation ?right-face-color R)
    =>
	(assert (must-be-front ?right-face-color))	
)

(defrule R4c1-same-color-edges-Front-face
	(is-done Y)
    (not (is-done cube))
	(Face ?c ? ?c ? ?c $?)
	(Face-Orientation ?c F)
	(Face-Orientation ?back-face-color B)
    =>
	(assert (must-be-front ?back-face-color))	
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Instanta 5 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;F2, U, L, Ri, F2, Li, R, U, F2

(defrule R5-is-done-cube (declare (salience 12))
	(not (is-done cube))
	(not (Face $? ?c $? ~?c $?))
	=>
	(assert (is-done cube))
)


(defrule R5a-upper-corners-done-NO-side-face-done (declare (salience 7))
	(is-done Y)
    (not (is-done cube))
	(not (Face ?c ? ~?c ? ~?c $?))
	(not (Face ?c&~W&~Y ?c ?c ?c ?c ?c ?c ?c ?c))
    =>
    (assert (move ?*move* F))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* F))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* L))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Ri))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* F))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* F))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Li))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* R))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* F))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* F))
	(bind ?*move* (+ ?*move* 1))
)	

(defrule R5b1-upper-corners-done-Right-face-done (declare (salience 6))
	(is-done Y)
    (not (is-done cube))
	(Face ?r ?r ?r ?r ?r ?r ?r ?r ?r)
	(Face-Orientation ?r R)
	(Face-Orientation ?left-face-color L)
    =>
	(assert (must-be-front ?left-face-color))	
)

(defrule R5b2-upper-corners-done-Left-face-done (declare (salience 6))
	(is-done Y)
    (not (is-done cube))
	(Face ?r ?r ?r ?r ?r ?r ?r ?r ?r)
	(Face-Orientation ?r L)
	(Face-Orientation ?right-face-color R)
    =>
	(assert (must-be-front ?right-face-color))	
)

(defrule R5b3-upper-corners-done-Front-face-done (declare (salience 6))
	(is-done Y)
    (not (is-done cube))
	(Face ?r ?r ?r ?r ?r ?r ?r ?r ?r)
	(Face-Orientation ?r F)
	(Face-Orientation ?back-face-color B)
    =>
	(assert (must-be-front ?back-face-color))	
)

(defrule R5b4-upper-corners-done-BACK-face-done-CLOCKWISE (declare (salience 6))
	(is-done Y)
    (not (is-done cube))
	(Face ?r ?r ?r ?r ?r ?r ?r ?r ?r)
	(Face-Orientation ?r B)
	(Face ? ?left-face-color ? ? ?front-face-color $?)
	(Face-Orientation ?front-face-color F)
	(Face-Orientation ?left-face-color L)
    =>
	(assert (move ?*move* F))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* F))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* L))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Ri))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* F))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* F))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Li))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* R))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* U))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* F))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* F))
	(bind ?*move* (+ ?*move* 1))
)
; F2, Ui, L, Ri, F2, Li, R, Ui, F2

(defrule R5b5-upper-corners-done-BACK-face-done-COUNTERCLOCKWISE (declare (salience 6))
	(is-done Y)
    (not (is-done cube))
	(not (Face ?r ?r ?r ?r ?r ?r ?r ?r ?r))
	(Face-Orientation ?r B)
	(Face ? ?right-face-color ? ? ?front-face-color $?)
	(Face-Orientation ?front-face-color F)
	(Face-Orientation ?right-face-color R)
    =>
	(assert (move ?*move* F))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* F))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Ui))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* L))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Ri))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* F))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* F))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Li))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* R))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* Ui))
	(bind ?*move* (+ ?*move* 1))
	(assert (move ?*move* F))
	(bind ?*move* (+ ?*move* 1))
    (assert (move ?*move* F))
	(bind ?*move* (+ ?*move* 1))
)








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ROTATIONS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (move <prioritate> <rotatie>), (Face <<<culoare>>>)
(defrule U-move (declare (salience 11))
	?s<-(Solution $?sol)
	?m<-(move ?nr U)
	(forall (move ?n ~U)(test (> ?n ?nr)))
	?U<-(Face ?U11 ?U12 ?U13 ?U21 Y ?U23 ?U31 ?U32 ?U33)
	?F<-(Face ?F11 ?F12 ?F13 ?F21 R $?rest-front)
	?R<-(Face ?R11 ?R12 ?R13 ?R21 G $?rest-right)
	?B<-(Face ?B11 ?B12 ?B13 ?B21 O $?rest-back)
	?L<-(Face ?L11 ?L12 ?L13 ?L21 B $?rest-left)
	=>
	(retract ?m ?U ?F ?R ?B ?L ?s)
	(assert
		(Face ?U31 ?U21 ?U11 ?U32 Y ?U12 ?U33 ?U23 ?U13)
		(Face ?R11 ?R12 ?R13 ?F21 R $?rest-front)
		(Face ?B11 ?B12 ?B13 ?R21 G $?rest-right)
		(Face ?L11 ?L12 ?L13 ?B21 O $?rest-back)
		(Face ?F11 ?F12 ?F13 ?L21 B $?rest-left)
		(Solution $?sol U)
	)
	(printout t "Moving U." crlf)	
)

; (move <prioritate> <rotatie>), (Face <<<culoare>>>)
(defrule Ui-move (declare (salience 11))
	?s<-(Solution $?sol)
	?m<-(move ?nr Ui)
	(forall (move ?n ~Ui)(test (> ?n ?nr)))
	?U<-(Face ?U11 ?U12 ?U13 ?U21 Y ?U23 ?U31 ?U32 ?U33)
	?F<-(Face ?F11 ?F12 ?F13 ?F21 R $?rest-front)
	?R<-(Face ?R11 ?R12 ?R13 ?R21 G $?rest-right)
	?B<-(Face ?B11 ?B12 ?B13 ?B21 O $?rest-back)
	?L<-(Face ?L11 ?L12 ?L13 ?L21 B $?rest-left)
	=>
	(retract ?m ?U ?F ?R ?B ?L ?s)
	(assert
		(Face ?U13 ?U23 ?U33 ?U12 Y ?U32 ?U11 ?U21 ?U31)
		(Face ?L11 ?L12 ?L13 ?F21 R $?rest-front)
		(Face ?F11 ?F12 ?F13 ?R21 G $?rest-right)
		(Face ?R11 ?R12 ?R13 ?B21 O $?rest-back)
		(Face ?B11 ?B12 ?B13 ?L21 B $?rest-left)
		(Solution $?sol Ui)
	)
	(printout t "Moving U inverse." crlf)	
)

; (move <prioritate> <rotatie>), (Face <<<culoare>>>)
(defrule R-move (declare (salience 11))
	?m<-(move ?nr R)
	?s<-(Solution $?sol)
	(forall (move ?n ~R)(test (> ?n ?nr)))
	?U<-(Face ?U11 ?U12 ?U13 ?U21 Y ?U23 ?U31 ?U32 ?U33)
	?F<-(Face ?F11 ?F12 ?F13 ?F21 ?front-face-color ?F23 ?F31 ?F32 ?F33)
	?R<-(Face ?R11 ?R12 ?R13 ?R21 ?right-face-color ?R23 ?R31 ?R32 ?R33)
	?B<-(Face ?B11 ?B12 ?B13 ?B21 ?back-face-color ?B23 ?B31 ?B32 ?B33)
	?D<-(Face ?D11 ?D12 ?D13 ?D21 W ?D23 ?D31 ?D32 ?D33)
	(Face-Orientation ?front-face-color F)
	(Face-Orientation ?right-face-color R)
	(Face-Orientation ?back-face-color B)	
	=>
	(retract ?m ?U ?F ?R ?B ?D ?s)
	(assert
		(Face ?R31 ?R21 ?R11 ?R32 ?right-face-color ?R12 ?R33 ?R23 ?R13)
		(Face ?F11 ?F12 ?D13 ?F21 ?front-face-color ?D23 ?F31 ?F32 ?D33)		
		(Face ?U11 ?U12 ?F13 ?U21 Y ?F23 ?U31 ?U32 ?F33)		
		(Face ?U33 ?B12 ?B13 ?U23 ?back-face-color ?B23 ?U13 ?B32 ?B33)		
		(Face ?D11 ?D12 ?B31 ?D21 W ?B21 ?D31 ?D32 ?B11)
		(Solution $?sol R)
	)
	(printout t "Moving R." crlf)	
)

; (move <prioritate> <rotatie>), (Face <<<culoare>>>)
(defrule Ri-move (declare (salience 11))
	?m<-(move ?nr Ri)
	?s<-(Solution $?sol)
	(forall (move ?n ~Ri)(test (> ?n ?nr)))
	?U<-(Face ?U11 ?U12 ?U13 ?U21 Y ?U23 ?U31 ?U32 ?U33)
	?F<-(Face ?F11 ?F12 ?F13 ?F21 ?front-face-color ?F23 ?F31 ?F32 ?F33)
	?R<-(Face ?R11 ?R12 ?R13 ?R21 ?right-face-color ?R23 ?R31 ?R32 ?R33)
	?B<-(Face ?B11 ?B12 ?B13 ?B21 ?back-face-color ?B23 ?B31 ?B32 ?B33)
	?D<-(Face ?D11 ?D12 ?D13 ?D21 W ?D23 ?D31 ?D32 ?D33)
	(Face-Orientation ?front-face-color F)
	(Face-Orientation ?right-face-color R)
	(Face-Orientation ?back-face-color B)
	=>
	(retract ?m ?U ?F ?R ?B ?D ?s)
	(assert
		(Face ?R13 ?R23 ?R33 ?R12 ?right-face-color ?R32 ?R11 ?R21 ?R31)       
        (Face ?U11 ?U12 ?B31 ?U21 Y ?B21 ?U31 ?U32 ?B11)
		(Face ?D33 ?B12 ?B13 ?D23 ?back-face-color ?B23 ?D13 ?B32 ?B33)
        (Face ?D11 ?D12 ?F13 ?D21 W ?F23 ?D31 ?D32 ?F33)
        (Face ?F11 ?F12 ?U13 ?F21 ?front-face-color ?U23 ?F31 ?F32 ?U33)
		(Solution $?sol Ri)
	)
	(printout t "Moving R inverse." crlf)	
)

; (move <prioritate> <rotatie>), (Face <<<culoare>>>)
(defrule L-move (declare (salience 11))
	?m<-(move ?nr L)
	?s<-(Solution $?sol)
	(forall (move ?n ~L)(test (> ?n ?nr)))
	?L<-(Face ?L11 ?L12 ?L13 ?L21 ?left-face-color ?L23 ?L31 ?L32 ?L33)
	?U<-(Face ?U11 ?U12 ?U13 ?U21 Y ?U23 ?U31 ?U32 ?U33)
	?F<-(Face ?F11 ?F12 ?F13 ?F21 ?front-face-color ?F23 ?F31 ?F32 ?F33)
	?B<-(Face ?B11 ?B12 ?B13 ?B21 ?back-face-color ?B23 ?B31 ?B32 ?B33)
	?D<-(Face ?D11 ?D12 ?D13 ?D21 W ?D23 ?D31 ?D32 ?D33)
	(Face-Orientation ?front-face-color F)
	(Face-Orientation ?left-face-color L)
	(Face-Orientation ?back-face-color B)
	=>
	(retract ?m ?U ?F ?L ?B ?D ?s)
	(assert
		(Face ?L31 ?L21 ?L11 ?L32 ?left-face-color ?L12 ?L33 ?L23 ?L13)
		(Face ?U11 ?F12 ?F13 ?U21 ?front-face-color ?F23 ?U31 ?F32 ?F33)
		(Face ?F11 ?D12 ?D13 ?F21 W ?D23 ?F31 ?D32 ?D33)		
		(Face ?B33 ?U12 ?U13 ?B23 Y ?U23 ?B13 ?U32 ?U33) 
		(Face ?B11 ?B12 ?D31 ?B21 ?back-face-color ?D21 ?B31 ?B32 ?D11) 
		(Solution $?sol L)
	)
	(printout t "Moving L." crlf)	
)

; (move <prioritate> <rotatie>), (Face <<<culoare>>>)
(defrule Li-move (declare (salience 11))
	?m<-(move ?nr Li)
	?s<-(Solution $?sol)
	(forall (move ?n ~Li)(test (> ?n ?nr)))
	?L<-(Face ?L11 ?L12 ?L13 ?L21 ?left-face-color ?L23 ?L31 ?L32 ?L33)
	?U<-(Face ?U11 ?U12 ?U13 ?U21 Y ?U23 ?U31 ?U32 ?U33)
	?F<-(Face ?F11 ?F12 ?F13 ?F21 ?front-face-color ?F23 ?F31 ?F32 ?F33)
	?B<-(Face ?B11 ?B12 ?B13 ?B21 ?back-face-color ?B23 ?B31 ?B32 ?B33)
	?D<-(Face ?D11 ?D12 ?D13 ?D21 W ?D23 ?D31 ?D32 ?D33)
	(Face-Orientation ?front-face-color F)
	(Face-Orientation ?left-face-color L)
	(Face-Orientation ?back-face-color B)
	=>
	(retract ?m ?U ?F ?L ?B ?D ?s)
	(assert
		(Face ?L13 ?L23 ?L33 ?L12 ?left-face-color ?L32 ?L11 ?L21 ?L31)
		(Face ?D11 ?F12 ?F13 ?D21 ?front-face-color ?F23 ?D31 ?F32 ?F33)		
		(Face ?F11 ?U12 ?U13 ?F21 Y ?U23 ?F31 ?U32 ?U33)			
		(Face ?B11 ?B12 ?U31 ?B21 ?back-face-color ?U21 ?B31 ?B32 ?U11)		
		(Face ?B33 ?D12 ?D13 ?B23 W ?D23 ?B13 ?D32 ?D33)
		(Solution $?sol Li)
	)
	(printout t "Moving L inverse." crlf)	
)

; (move <prioritate> <rotatie>), (Face <<<culoare>>>)
(defrule F-move (declare (salience 11))
	?m<-(move ?nr F)
	?s<-(Solution $?sol)
	(forall (move ?n ~F)(test (> ?n ?nr)))
	?L<-(Face ?L11 ?L12 ?L13 ?L21 ?left-face-color ?L23 ?L31 ?L32 ?L33)
	?U<-(Face $?rest-up Y ?U23 ?U31 ?U32 ?U33)
	?F<-(Face ?F11 ?F12 ?F13 ?F21 ?front-face-color ?F23 ?F31 ?F32 ?F33)
	?D<-(Face ?D11 ?D12 ?D13 ?D21 W $?rest-down)
	?R<-(Face ?R11 ?R12 ?R13 ?R21 ?right-face-color ?R23 ?R31 ?R32 ?R33)
	(Face-Orientation ?front-face-color F)
	(Face-Orientation ?left-face-color L)
	(Face-Orientation ?right-face-color R)
	=>
	(retract ?m ?U ?F ?L ?D ?R ?s)
	(assert
		(Face ?F31 ?F21 ?F11 ?F32 ?front-face-color ?F12 ?F33 ?F23 ?F13)		
		(Face ?L11 ?L12 ?D11 ?L21 ?left-face-color ?D12 ?L31 ?L32 ?D13)		
		(Face $?rest-up Y ?U23 ?L33 ?L23 ?L13)
	    (Face ?R31 ?R21 ?R11 ?D21 W $?rest-down) ; 	
		(Face ?U31 ?R12 ?R13 ?U32 ?right-face-color ?R23 ?U33 ?R32 ?R33)
		(Solution $?sol F)
	)
	(printout t "Moving F." crlf)	
)


; (move <prioritate> <rotatie>), (Face <<<culoare>>>)
(defrule Fi-move (declare (salience 11))
	?m<-(move ?nr Fi)
	?s<-(Solution $?sol)
	(forall (move ?n ~Fi)(test (> ?n ?nr)))
	?L<-(Face ?L11 ?L12 ?L13 ?L21 ?left-face-color ?L23 ?L31 ?L32 ?L33)
	?U<-(Face $?rest-up Y ?U23 ?U31 ?U32 ?U33)
	?F<-(Face ?F11 ?F12 ?F13 ?F21 ?front-face-color ?F23 ?F31 ?F32 ?F33)
	?D<-(Face ?D11 ?D12 ?D13 ?D21 W $?rest-down)
	?R<-(Face ?R11 ?R12 ?R13 ?R21 ?right-face-color ?R23 ?R31 ?R32 ?R33)
	(Face-Orientation ?front-face-color F)
	(Face-Orientation ?left-face-color L)
	(Face-Orientation ?right-face-color R)
    =>
	(retract ?m ?U ?F ?L ?D ?R ?s)
	(assert
		(Face ?F13 ?F23 ?F33 ?F12 ?front-face-color ?F32 ?F11 ?F21 ?F31)		
		(Face ?L11 ?L12 ?U33 ?L21 ?left-face-color ?U32 ?L31 ?L32 ?U31)		
		(Face $?rest-up Y ?U23 ?R11 ?R21 ?R31)		
		(Face ?L13 ?L23 ?L33 ?D21 W $?rest-down)		
		(Face ?D13 ?R12 ?R13 ?D12 ?right-face-color ?R23 ?D11 ?R32 ?R33)	
		(Solution $?sol Fi)
	)
	(printout t "Moving F inverse." crlf)	
)


; (move <prioritate> <rotatie>), (Face <<<culoare>>>)
(defrule D-move (declare (salience 11))
	?m<-(move ?nr D)
	?s<-(Solution $?sol)
	(forall (move ?n ~D)(test (> ?n ?nr)))
		?F<-(Face $?rest-front R ?F23 ?F31 ?F32 ?F33)
		?L<-(Face $?rest-left B ?L23 ?L31 ?L32 ?L33)
		?R<-(Face $?rest-right G ?R23 ?R31 ?R32 ?R33)
		?B<-(Face $?rest-back O ?B23 ?B31 ?B32 ?B33)
		?D<-(Face ?D11 ?D12 ?D13 ?D21 W ?D23 ?D31 ?D32 ?D33)
	=>
	(retract ?m ?R ?F ?L ?B ?D ?s)
	(assert
            (Face ?D31 ?D21 ?D11 ?D32 W ?D12 ?D33 ?D23 ?D13)
			(Face $?rest-front R ?F23 ?L31 ?L32 ?L33)	
			(Face $?rest-left B ?L23 ?B31 ?B32 ?B33)
			(Face $?rest-right G ?R23 ?F31 ?F32 ?F33)
			(Face $?rest-back O ?B23 ?R31 ?R32 ?R33)
			(Solution $?sol D)
	)
	(printout t "Moving D." crlf)	
)

; (move <prioritate> <rotatie>), (Face <<<culoare>>>)
(defrule Di-move (declare (salience 11))
	?m<-(move ?nr Di)
	?s<-(Solution $?sol)
	(forall (move ?n ~Di)(test (> ?n ?nr)))
	
		?F<-(Face ?F11 ?F12 ?F13 ?F21 R ?F23 $?front-last-line)
		?L<-(Face ?L11 ?L12 ?L13 ?L21 B ?L23 $?left-last-line)
		?R<-(Face ?R11 ?R12 ?R13 ?R21 G ?R23 $?right-last-line)
		?B<-(Face ?B11 ?B12 ?B13 ?B21 O ?B23 $?back-last-line)
		?D<-(Face ?D11 ?D12 ?D13 ?D21 W ?D23 ?D31 ?D32 ?D33)
	=>
	(retract ?m ?R ?F ?L ?B ?D ?s)
	(assert
            (Face ?D13 ?D23 ?D33 ?D12 W ?D32 ?D11 ?D21 ?D31)            
			(Face ?F11 ?F12 ?F13 ?F21 R ?F23 $?right-last-line)
			(Face ?L11 ?L12 ?L13 ?L21 B ?L23 $?front-last-line)
			(Face ?R11 ?R12 ?R13 ?R21 G ?R23 $?back-last-line)
			(Face ?B11 ?B12 ?B13 ?B21 O ?B23 $?left-last-line)
			(Solution $?sol Di)
	)
	(printout t "Moving D inverse." crlf)	
)

; (move <prioritate> <rotatie>), (Face <<<culoare>>>)
(defrule B-move (declare (salience 11))
	?m<-(move ?nr B)
	?s<-(Solution $?sol)
	(forall (move ?n ~B)(test (> ?n ?nr)))
		?U<-(Face ?U11 ?U12 ?U13 ?U21 Y  ?U23 ?U31 ?U32 ?U33)
		?L<-(Face ?L11 ?L12 ?L13 ?L21 ?left-face-color ?L23 ?L31 ?L32 ?L33)
		?R<-(Face ?R11 ?R12 ?R13 ?R21 ?right-face-color ?R23 ?R31 ?R32 ?R33)
		?B<-(Face ?B11 ?B12 ?B13 ?B21 ?back-face-color ?B23 ?B31 ?B32 ?B33)
		?D<-(Face ?D11 ?D12 ?D13 ?D21 W ?D23 ?D31 ?D32 ?D33)
		(Face-Orientation ?back-face-color B)
		(Face-Orientation ?left-face-color L)
		(Face-Orientation ?right-face-color R)
	=>
	(retract ?m ?R ?U ?L ?B ?D ?s)
	(assert
    		(Face ?B31 ?B21 ?B11 ?B32 ?back-face-color ?B12 ?B33 ?B23 ?B13)            
			(Face ?R13 ?R23 ?R33 ?U21 Y ?U23 ?U31 ?U32 ?U33)        
			(Face ?U13 ?L12 ?L13 ?U12 ?left-face-color ?L23 ?U11 ?L32 ?L33)           
			(Face ?R11 ?R12 ?D33 ?R21 ?right-face-color ?D32 ?R31 ?R32 ?D31)
			(Face ?D11 ?D12 ?D13 ?D21 W ?D23 ?L11 ?L21 ?L31)
			(Solution $?sol B)
	)
	(printout t "Moving B." crlf)	
)

; (move <prioritate> <rotatie>), (Face <<<culoare>>>)
(defrule Bi-move (declare (salience 11))
	?m<-(move ?nr Bi)
	?s<-(Solution $?sol)
	(forall (move ?n ~Bi)(test (> ?n ?nr)))
		?U<-(Face ?U11 ?U12 ?U13 ?U21 Y  ?U23 ?U31 ?U32 ?U33)
		?L<-(Face ?L11 ?L12 ?L13 ?L21 ?left-face-color ?L23 ?L31 ?L32 ?L33)
		?R<-(Face ?R11 ?R12 ?R13 ?R21 ?right-face-color ?R23 ?R31 ?R32 ?R33)
		?B<-(Face ?B11 ?B12 ?B13 ?B21 ?back-face-color ?B23 ?B31 ?B32 ?B33)
		?D<-(Face ?D11 ?D12 ?D13 ?D21 W ?D23 ?D31 ?D32 ?D33)
		(Face-Orientation ?back-face-color B)
		(Face-Orientation ?left-face-color L)
		(Face-Orientation ?right-face-color R)
	=>
	(retract ?m ?R ?U ?L ?B ?D ?s)
	(assert
    		(Face ?B13 ?B23 ?B33 ?B12 ?back-face-color ?B32 ?B11 ?B21 ?B31)            
			(Face ?L31 ?L21 ?L11 ?U21 Y ?U23 ?U31 ?U32 ?U33)
			(Face ?D31 ?L12 ?L13 ?D32 ?left-face-color ?L23 ?D33 ?L32 ?L33)
			(Face ?R11 ?R12 ?U11 ?R21 ?right-face-color ?U12 ?R31 ?R32 ?U13)
			(Face ?D11 ?D12 ?D13 ?D21 W ?D23 ?R33 ?R23 ?R13)
			(Solution $?sol Bi)
	)
	(printout t "Moving B inverse." crlf)	
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Change Orientation ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Fiind data culoarea fetei care trebuie sa devina fata frontala, se redefineste orientarea fiecareia dintre fetele laterale

; (must-be-front <color-of-current-right-face>), (Face-Orientation <color> <orientation>), (Face <<<color>>>)
(defrule change-orientation-right-to-front (declare (salience 12))
	; (not (must-be-front ?))
	?a<-(must-be-front ?r)
	?s<-(Solution $?sol)
	?front<-(Face-Orientation ?f F)
    ?right<-(Face-Orientation ?r R)
	?back<-(Face-Orientation ?b B)
	?left<-(Face-Orientation ?l L)
	?U<-(Face ?U11 ?U12 ?U13 ?U21 Y ?U23 ?U31 ?U32 ?U33)
	?D<-(Face ?D11 ?D12 ?D13 ?D21 W ?D23 ?D31 ?D32 ?D33)
	=>
	(retract ?a ?front ?right ?back ?left ?U ?D ?s)
	(assert
		(Face ?U31 ?U21 ?U11 ?U32 Y ?U12 ?U33 ?U23 ?U13)
		(Face ?D13 ?D23 ?D33 ?D12 W ?D32 ?D11 ?D21 ?D31)
		(Face-Orientation ?r F)
		(Face-Orientation ?b R)
		(Face-Orientation ?l B)
		(Face-Orientation ?f L)
		(Solution $?sol Rotate-Cube-So-Front-Color-is ?r)
	)
	(printout t "Changing orientation. Now: Front=" ?r ", Right=" ?b ", Back=" ?l ", Left=" ?f crlf)
)

; (must-be-front <color-of-current-back-face>), (Face-Orientation <color> <orientation>), (Face <<<color>>>)
(defrule change-orientation-back-to-front (declare (salience 12))
	; (not (must-be-front ?))
	?a<-(must-be-front ?b)
	?s<-(Solution $?sol)
	?front<-(Face-Orientation ?f F)
    ?right<-(Face-Orientation ?r R)
	?back<-(Face-Orientation ?b B)
	?left<-(Face-Orientation ?l L)
	?U<-(Face ?U11 ?U12 ?U13 ?U21 Y ?U23 ?U31 ?U32 ?U33)
	?D<-(Face ?D11 ?D12 ?D13 ?D21 W ?D23 ?D31 ?D32 ?D33)
	=>
	(retract ?a ?front ?right ?back ?left ?U ?D ?s) 
	(assert
		(Face ?U33 ?U32 ?U31 ?U23 Y ?U21 ?U13 ?U12 ?U11)
		(Face ?D33 ?D32 ?D31 ?D23 W ?D21 ?D13 ?D12 ?D11)
		(Face-Orientation ?b F)
		(Face-Orientation ?l R)
		(Face-Orientation ?f B)
		(Face-Orientation ?r L)
		(Solution $?sol Rotate-Cube-So-Front-Color-is ?b)
	)
	(printout t "Changing orientation. Now: Front=" ?b ", Right=" ?l ", Back=" ?f ", Left=" ?r crlf)
)
; (must-be-front <color-of-current-left-face>), (Face-Orientation <color> <orientation>), (Face <<<color>>>)
(defrule change-orientation-left-to-front (declare (salience 12))
	; (not (must-be-front ?))
	?a<-(must-be-front ?l)
	?s<-(Solution $?sol)
	?front<-(Face-Orientation ?f F)
    ?right<-(Face-Orientation ?r R)
	?back<-(Face-Orientation ?b B)
	?left<-(Face-Orientation ?l L)
	?U<-(Face ?U11 ?U12 ?U13 ?U21 Y ?U23 ?U31 ?U32 ?U33)
	?D<-(Face ?D11 ?D12 ?D13 ?D21 W ?D23 ?D31 ?D32 ?D33)
	=>
	(retract ?a ?front ?right ?back ?left ?U ?D ?s)
	(assert
		(Face ?U13 ?U23 ?U33 ?U12 Y ?U32 ?U11 ?U21 ?U31)
		(Face ?D31 ?D21 ?D11 ?D32 W ?D12 ?D33 ?D23 ?D13)
		(Face-Orientation ?l F)
		(Face-Orientation ?f R)
		(Face-Orientation ?r B)
		(Face-Orientation ?b L)
		(Solution $?sol Rotate-Cube-So-Front-Color-is ?l)
	)
	(printout t "Changing orientation. Now: Front=" ?l ", Right=" ?f ", Back=" ?r ", Left=" ?b crlf)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





