(deffacts init
	; Front = Red, Right = Green, Left = Blue, Back = Orange, Down = White, Up = Yellow)
	; 	Y
	; B R G O
	;	W
	
	; Representation of Face tiles: left -> right, up -> down
	;White Face is Done 
	(Face W W W W W W W W W)
	(Face O Y O O Y O G Y B)
	
	(Face R G R B R B R R R)
	(Face Y G Y Y G G G G G)
	(Face G R B R O B O O O)
	(Face Y Y Y O B R B B B)
	
	(move 4 U)
	(move 1 U)
	(move 2 R)
	(move 3 Ui)
		
	; add scop cu nr reprezentand pasii in ordine
	; salience of executing moves needs to be higher than the one for adding moves
)

(defglobal ?*move* = 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Middle Layer - MOVE EDGE PIECE TO THE RIGHT
(defrule move-right-edge-piece-F-face
	;Middle Layer not done
	(exists (Face ? ? ? ?e1 ?fixed&~Y ?e2&~?e1|~?fixed $?)) 
	;Edge piece that doesn't contain yellow and needs to be moved to the right
	(Face ? R ? ? R $?)
	(Face ? ? ? ? Y ? ? G ?)
	=>
	(printout t "Middle layer not done. MOVE FRONT-EDGE TO THE RiGHT. " crlf)
)
(defrule move-right-edge-piece-R-face
	(exists (Face ? ? ? ?e1 ?fixed&~Y ?e2&~?e1|~?fixed $?)) 
	(Face ? G ? ? G $?)
	(Face ? ? ? ? Y O $?)
	=>
	(printout t "Middle layer not done. MOVE RIGHT-EDGE TO THE RiGHT. " crlf)
)
(defrule move-right-edge-piece-B-face
	(exists (Face ? ? ? ?e1 ?fixed&~Y ?e2&~?e1|~?fixed $?)) 
	(Face ? O ? ? O $?)
	(Face ? B ? ? Y $?)
	=>
	(printout t "Middle layer not done. MOVE BACK-EDGE TO THE RiGHT. " crlf)
)
(defrule move-right-edge-piece-L-face
	(exists (Face ? ? ? ?e1 ?fixed&~Y ?e2&~?e1|~?fixed $?)) 
	(Face ? B ? ? B $?)
	(Face ? ? ? R Y $?)
	=>
	(printout t "Middle layer not done. MOVE LEFT-EDGE TO THE RiGHT. " crlf)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule all-edge-pieces-contain-yellow 
	(exists (Face ? ? ? ?e1 ?fixed&~Y ?e2&~?e1|~?fixed $?)) 
	(Face ? ?O-peer ? ?B-peer Y ?G-peer ? ?R-peer ?)
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
	(forall (move ?n ~U)(test (> ?n ?nr)))
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
	(forall (move ?n ~Ui)(test (> ?n ?nr)))
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

; R move
(defrule R-move
	?m<-(move ?nr R)
	(forall (move ?n ~R)(test (> ?n ?nr)))
	?U<-(Face ?U11 ?U12 ?U13 ?U21 Y ?U23 ?U31 ?U32 ?U33)
	?F<-(Face ?F11 ?F12 ?F13 ?F21 R ?F23 ?F31 ?F32 ?F33)
	?R<-(Face ?R11 ?R12 ?R13 ?R21 G ?R23 ?R31 ?R32 ?R33)
	?B<-(Face ?B11 ?B12 ?B13 ?B21 O ?B23 ?B31 ?B32 ?B33)
	?D<-(Face ?D11 ?D12 ?D13 ?D21 W ?D23 ?D31 ?D32 ?D33)
	=>
	(retract ?m ?U ?F ?R ?B ?D)
	(assert
		(Face ?R31 ?R21 ?R11 ?R32 G ?R12 ?R33 ?R23 ?R13)
		(Face ?F11 ?F12 ?D13 ?F21 R ?D23 ?F31 ?F32 ?D33)		
		(Face ?U11 ?U12 ?F13 ?U21 Y ?F23 ?U31 ?U32 ?F33)		
		(Face ?U33 ?B12 ?B13 ?U23 O ?B23 ?U13 ?B32 ?B33)		
		(Face ?D11 ?D12 ?B31 ?D21 W ?B21 ?D31 ?D32 ?B11)	
	)
	(printout t "Moving R." crlf)	
)

; R inverse
(defrule R-move
	?m<-(move ?nr R)
	(forall (move ?n ~R)(test (> ?n ?nr)))
	?U<-(Face ?U11 ?U12 ?U13 ?U21 Y ?U23 ?U31 ?U32 ?U33)
	?F<-(Face ?F11 ?F12 ?F13 ?F21 R ?F23 ?F31 ?F32 ?F33)
	?R<-(Face ?R11 ?R12 ?R13 ?R21 G ?R23 ?R31 ?R32 ?R33)
	?B<-(Face ?B11 ?B12 ?B13 ?B21 O ?B23 ?B31 ?B32 ?B33)
	?D<-(Face ?D11 ?D12 ?D13 ?D21 W ?D23 ?D31 ?D32 ?D33)
	=>
	(retract ?m ?U ?F ?R ?B ?D)
	(assert
		(Face ?R13 ?R23 ?R33 ?R12 G ?R32 ?R11 ?R21 ?R31)
			
	)
	(printout t "Moving R." crlf)	
)
; (Face ?R13 ?R23 ?R33 ?R12 G ?R32 ?R11 ?R21 ?R31)

