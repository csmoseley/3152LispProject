;;; Code for the form named :maindisplay of class bitmap-window.
;;; The inspector may add event-handler starter code here,
;;; and you may add other code for this form as well.
;;; The code for recreating the window is auto-generated into 
;;; the *.bil file having the same name as this *.cl file.

(in-package :common-graphics-user)

(defvar gamestarted)
(defvar gamemap)

(defvar message)

(defvar printedmap)

(defvar outputholder)

(defvar tempS)

(defvar playerloc)

(defvar futureplayerloc)

(defvar roomh)

(defvar roomw)

(defun settestmap(hval wval) ; generates the map for the test environment
  (setq gamemap NIL)
  (setq gamemap (make-array (list hval wval)))
  (setq printedmap NIL)
  (setq printedmap (make-array (list hval wval)))


  (format t "testmap generated~%")
  )

(defun gengamemap(newh neww)
  (loop for k from 0 to (- neww 1) do 
        (loop for i from 0 to (- newh 1) do 
              (if 
                  (or (or (equal (- newh 1) k) (equal (- neww 1) i))(or (equal 0 k) (equal 0 i)))
                  (progn (setf (aref gamemap k i) "X "))
                (progn (setf (aref gamemap k i) "  ")))
              ))  
  )

(defun printgamemap()
  (gengamemap (nth 0 (array-dimensions printedmap)) (nth 1 (array-dimensions printedmap)))
  (setq printedmap gamemap)
  (setf (aref printedmap (nth 0 playerloc) (nth 1 playerloc)) "P ")
  (setq roomw (nth 0 (array-dimensions gamemap)))
  (setq roomh (nth 1 (array-dimensions gamemap)))
  (loop for k from 0 to (- roomw 1) do 
        (loop for i from 0 to (- roomh 1) do 
              (if (EQUAL i (- roomw 1))
                  (progn  
                   (setq outputholder (concatenate 'String outputholder (aref printedmap k i)))
                    (setq outputholder (concatenate 'String outputholder (coerce '(#\newline) 'string))))
                    (setq outputholder (concatenate 'String outputholder (aref printedmap k i) ))
                )
              
              )
        
        )
  )

(defun testthemap()
  (setq playerloc '(2 3))  
  (settestmap 12 12)
  (setq outputholder (coerce '(#\newline) 'string))
  (format t "settestmap generated~%")
  (format t "gengamemap~%")
  (printgamemap)
  )
(defun checkforwall(xycoor)
  (if(equal (aref gamemap (nth 0 xycoor) (nth 1 xycoor) ) "X ")
     '(T)
    '(NIL)
    )
  )

(defun checkfornpc()
  '(NIL)
  )

(defun move(direction)
  (setq outputholder (coerce '(#\newline) 'string))
  (setq message "")
  (setq futureplayerloc (list (nth 0 playerloc) (nth 1 playerloc)))
  (case direction
    ('d (setq futureplayerloc (list (nth 0 playerloc) (+ (nth 1 playerloc) 1))))
    ('a (setq futureplayerloc (list (nth 0 playerloc) (- (nth 1 playerloc) 1))))
    ('w (setq futureplayerloc (list (- (nth 0 playerloc) 1) (nth 1 playerloc))))
    ('s (setq futureplayerloc (list (+ (nth 0 playerloc) 1) (nth 1 playerloc))))
    (otherwise (format t "This is not a direction.~%")))
  (if (nth 0 (or (checkforwall futureplayerloc) (checkfornpc)))
      (setq message (concatenate 'String message "Something is in the way." (coerce '(#\newline) 'string)))
    (setq playerloc futureplayerloc)
    )
  (printgamemap)
  (setq outputholder (concatenate 'String outputholder (coerce '(#\newline) 'string) message))
  
  )

(defun maindisplay-button7-on-click (dialog widget)
  (declare (ignorable dialog widget))
  ;; NOTE:  Usually it is better to use an on-change function rather
  ;; than an on-click function.  See the doc pages for those properties.
  (move 'd)
  (setf (value (find-component :gameoutput :maindisplay)) outputholder)
  )
(defun maindisplay-button5-on-click-1 (dialog widget)
  (declare (ignorable dialog widget))
  ;; NOTE:  Usually it is better to use an on-change function rather
  ;; than an on-click function.  See the doc pages for those properties.
  (move 'a)
  (setf (value (find-component :gameoutput :maindisplay)) outputholder)
  )

(defun maindisplay-button6-on-click (dialog widget)
  (declare (ignorable dialog widget))
  ;; NOTE:  Usually it is better to use an on-change function rather
  ;; than an on-click function.  See the doc pages for those properties.
  (move 'w)
  (setf (value (find-component :gameoutput :maindisplay)) outputholder)
  )

(defun maindisplay-button8-on-click (dialog widget)
  (declare (ignorable dialog widget))
  ;; NOTE:  Usually it is better to use an on-change function rather
  ;; than an on-click function.  See the doc pages for those properties.
  (move 's)
  (setf (value (find-component :gameoutput :maindisplay)) outputholder)
  )

(defun maindisplay-button9-on-click (dialog widget)
  (declare (ignorable dialog widget))
  ;; NOTE:  Usually it is better to use an on-change function rather
  ;; than an on-click function.  See the doc pages for those properties.
  (testthemap)
  (setf (value (find-component :gameoutput :maindisplay)) outputholder)
  (setf (available (find-component :button8 :maindisplay)) T)
  (setf (available (find-component :button6 :maindisplay)) T)
  (setf (available (find-component :button7 :maindisplay)) T)
  (setf (available (find-component :button5 :maindisplay)) T)
  )
