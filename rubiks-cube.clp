(deffacts init
	; Current color assigned to face-orientation (Front,Right,Left,Back,Down,Up)
	(Color D W)
	(Color U Y)
	
	(Color F R)
	(Color R G)
	(Color L B)
	(Color B O)
	
	;(NeighboursRL <current> <right-neighbour> <left-neighbour>)
	(NeighboursRL R G B)
	(NeighboursRL G O R)
	(NeighboursRL O B G)
	(NeighboursRL B R O)
	
	; left -> right, up -> down
	; 1st 3 : F, 2nd 3 : R, 3rd 3 : B, 4th 3 : L
	; (White-Face-Adjacent R R R G G G O O O B B B)
	
	;White Face is Done 
	(Face W W W W W W W W W)
	(Face O Y O O Y O G Y B)
	
	(Face R G R B R B R R R)
	(Face Y G Y Y G G G G G)
	(Face G R B R O B O O O)
	(Face Y Y Y O B R B B B)
	
	(Up-Layer F11 F12 F13 R11 R12 R13 B11 B12 B13 L11 L12 L13)
	(Down-Layer F31 F32 F33 R31 R32 R33 B31 B32 B33 L31 L32 L33)
	
	; add scop cu nr reprezentand pasii in ordine
)

(defglobal ?*move* = 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Middle Layer - MOVE EDGE PIECE TO THE RIGHT
(defrule move-right-edge-piece-F-face
	;Middle Layer not done
	(exists (Face ? ? ? ?e1 ?fixed&~Y ?e2&~?e1|~?fixed $?)) 
	;Edge piece that doesn't contain yellow
	(Color F ?fixed-front)
	(Face ? ?fixed-front&~Y ? ? ?fixed-front $?)
	(Face ? ? ? ? Y ? ? ?edge-up&~Y ?)
	(NeighboursRL ?fixed-front ?edge-up ?)
	=>
	(printout t "Middle layer not done. MOVE FRONT-EDGE TO THE RiGHT. " crlf)
)
(defrule move-right-edge-piece-R-face
	;Middle Layer not done
	(exists (Face ? ? ? ?e1 ?fixed&~Y ?e2&~?e1|~?fixed $?)) 
	;Edge piece that doesn't contain yellow
	(Color R ?fixed)
	(Face ? ?fixed&~Y ? ? ?fixed $?)
	(Face ? ? ? ? Y ?edge-up&~Y ? ? ?)
	(NeighboursRL ?fixed ?edge-up ?)
	=>
	(printout t "Middle layer not done. MOVE RIGHT-EDGE TO THE RiGHT. " crlf)
)
(defrule move-right-edge-piece-B-face
	;Middle Layer not done
	(exists (Face ? ? ? ?e1 ?fixed&~Y ?e2&~?e1|~?fixed $?)) 
	;Edge piece that doesn't contain yellow
	(Color B ?fixed)
	(Face ? ?fixed&~Y ? ? ?fixed $?)
	(Face ? ?edge-up&~Y ? ? Y ? ? ? ?)
	(NeighboursRL ?fixed ?edge-up ?)
	=>
	(printout t "Middle layer not done. MOVE BACK-EDGE TO THE RiGHT. " crlf)
)
(defrule move-right-edge-piece-L-face
	;Middle Layer not done
	(exists (Face ? ? ? ?e1 ?fixed&~Y ?e2&~?e1|~?fixed $?)) 
	;Edge piece that doesn't contain yellow
	(Color L ?fixed)
	(Face ? ?fixed&~Y ? ? ?fixed $?)
	(Face ? ? ? ?edge-up&~Y Y ? ? ? ?)
	(NeighboursRL ?fixed ?edge-up ?)
	=>
	(printout t "Middle layer not done. MOVE LEFT-EDGE TO THE RiGHT. " crlf)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule all-edge-pieces-contain-yellow ;(declare (salience 10)) ; salience bigger than for moving edge piece to the right or left
	;Middle Layer not done
	(exists (Face ? ? ? ?e1 ?fixed&~Y ?e2&~?e1|~?fixed $?)) 
	(Face ? ?O-peer ? ?B-peer Y ?G-peer ? ?R-peer ?)
	;(test (or)()()())
	=>
	(printout t "Middle layer not done. " crlf)
)

;Rotations
;	?U<-(Face ?U11 ?U12 ?U13 ?U21 Y ?U23 ?U31 ?U32 ?U33)
;	?F<-(Face ?F11 ?F12 ?F13 ?F21 R ?F23 ?F31 ?F32 ?F33)
;	?R<-(Face ?R11 ?R12 ?R13 ?R21 G ?R23 ?R31 ?R32 ?R33)
;	?B<-(Face ?B11 ?B12 ?B13 ?B21 O ?B23 ?B31 ?B32 ?B33)
;	?L<-(Face ?L11 ?L12 ?L13 ?L21 O ?L23 ?L31 ?L32 ?L33)
;	?U11 ?U12 ?U13
;	?U21 Y ?U23
;	?U31 ?U32 ?U33

; U rotation
(defrule U-move
	?m<-(move ?nr U)
	(not (move ?n:<?nr ?))
	?U<-(Face ?U11 ?U12 ?U13 ?U21 Y ?U23 ?U31 ?U32 ?U33)
	?F<-(Face ?F11 ?F12 ?F13 ?F21 R $?rest-front)
	?R<-(Face ?R11 ?R12 ?R13 ?R21 G $?rest-right)
	?B<-(Face ?B11 ?B12 ?B13 ?B21 O $?rest-back)
	?L<-(Face ?L11 ?L12 ?L13 ?L21 B $?rest-left)
	=>
	(retract ?m ?U ?F ?R ?B ?L)
	(assert
		(Face ?U31 ?U21 ?U11 ?U32 Y ?U12 ?U33 ?U23 ?U13)
		(Face ?R11 ?R12 ?R13 ?F21 R $?rest-front)
		(Face ?B11 ?B12 ?B13 ?R21 G $?rest-right)
		(Face ?L11 ?L12 ?L13 ?B21 O $?rest-back)
		(Face ?F11 ?F12 ?F13 ?L21 B $?rest-left)
	
	)
	(printout t "Moving U." crlf)	
)

; U inverse
(defrule Ui-move
	?m<-(move ?nr Ui)
	(not (move ?n:<?nr ?))
	?U<-(Face ?U11 ?U12 ?U13 ?U21 Y ?U23 ?U31 ?U32 ?U33)
	?F<-(Face ?F11 ?F12 ?F13 ?F21 R $?rest-front)
	?R<-(Face ?R11 ?R12 ?R13 ?R21 G $?rest-right)
	?B<-(Face ?B11 ?B12 ?B13 ?B21 O $?rest-back)
	?L<-(Face ?L11 ?L12 ?L13 ?L21 B $?rest-left)
	=>
	(retract ?m ?U ?F ?R ?B ?L)
	(assert
		(Face ?U13 ?U23 ?U33 ?U12 Y ?U32 ?U11 ?U21 ?U31)
		(Face ?L11 ?L12 ?L13 ?F21 R $?rest-front)
		(Face ?F11 ?F12 ?F13 ?R21 G $?rest-right)
		(Face ?R11 ?R12 ?R13 ?B21 O $?rest-back)
		(Face ?B11 ?B12 ?B13 ?L21 B $?rest-left)
	
	)
	(printout t "Moving U inverse." crlf)	
)






