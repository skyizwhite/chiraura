(ql:quickload :clgplot)

(defun factorial (n)
  (if (= n 0)              
      1                           
      (* n (factorial (- n 1)))))

(defun erlang-b (rho c)
  (/ (/ (expt rho c)
        (factorial c))
     (loop :for x :from 0 :to c
           :sum (/ (expt rho x)
                   (factorial x)))))

(defparameter *x-list* (loop :for x :from 0 :to 100 :collect x))

(defun plot (c)
  (clgp:plot (mapcar #'(lambda (x) (erlang-b x c)) *x-list*)
             :title (format nil "c=~a" c)
             :x-label "ρ (Erlang)"
             :y-label "Blocking propabillity"
             :output #P"./erlang-b.png")
  (format t "blocking propabillity: ~a " (float (erlang-b 50 c)))
  (if (< (erlang-b 50 c) 0.001)
      (format t "ok~%")
      (format t "ng~%")))

(plot 70)
;blocking propabillity: 0.0013679281 ng
(plot 71)
;blocking propabillity: 9.6240256e-4 ok
