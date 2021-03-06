;; some basic functionality that I miss from clojure
(display "loading aod/clj.scm\n")
(provide 'aod.clj)

#;
(define-macro (comment . body)
   `())

;; #<unspecified> or () is better?
(define-expansion (comment . body) #<unspecified>)

;; hm that fails
;; (define-expansion (comment . body) (values))

(define map-indexed
  (let ((+documentation+ "(map-indexed f coll)
Applies f to the collection coll.
f should accept to arguments, i and the element")
	(+signature+ '(f coll)))
    (lambda (f coll)
      (let ((i -1))
	(map (lambda (el)
	       (set! i (+ 1 i))
	       (f i el))
	     coll)))))

(comment
 (map-indexed (lambda (i el)
		(format *stdout* "i ~A el ~A\n" i el))
	      '(a b c))
 
;; i 0 el a
;; i 1 el b
;; i 2 el c
 )

;; got from s7.. stuff.scm ?
(define-macro (dotimes spec . body)	;; spec = (var end . return)
	(let ((e (gensym))
	      (n (car spec)))
	  `(do ((,e ,(cadr spec))
		(,n 0 (+ ,n 1)))
	       ((>= ,n ,e) ,@(cddr spec))
	     ,@body)))

(comment
 (dotimes (i 3)
   ;; (display "here")
   (format *stderr* "i is ~A\n" i)
   )
 "
i is 0
i is 1
i is 2
"
 => #t

 (dotimes (i 3 (format #f "finished with i ~A" i)) ;; <= the 3rd i is the return statement. could be anything
   ;; (display "here")
   (format *stderr* "i is ~A\n" i)
   )
 "i is 0
i is 1
i is 2
"
 => "finished with i 3"
 )

(define iota
  (let ((+documentation+ "(iota n (start 0) (incr 1)) returns a list counting from start for n:\n\
    (iota 3) -> '(0 1 2)"))
    (lambda* (n (start 0) (incr 1))
      (if (or (not (integer? n))
	      (< n 0))
	  (error 'wrong-type-arg "iota length ~A should be a non-negative integer" n))
      (let ((lst (make-list n)))
	(do ((p lst (cdr p))
	     (i start (+ i incr)))
	    ((null? p) lst)
	  (set! (car p) i))))))

(define range iota)
(define mod modulo)

(define-macro (not= . args)
  `(not (= ,@args)))

#;
(define-expansion (pow base power)
(expt base power))

(define pow expt)

(define-expansion (identity what)
  `,what)

(define-macro (watch var fn)
  `(set! (setter ',var) 
	 (lambda (s v e)
	   ;; calling fn with old and new value
	   (,fn (e ',var) v)
	   v)))

(comment
 (define x 1)
 (watch x (lambda (old new)
		(print "x changed from" old "to" new)))
 ((curlet) 'x)
 (define x 2)
 )

(define (keys coll)
  (if (or (hash-table? coll)
	  (let? coll))
      (map (lambda  (el)
	     (car el))
	   coll)
      (error 'wrong-type-arg "keys arg ~A is not a hash-table nor a let" coll)))

(define (inc x)
  (+ x 1))

(define (dec x)
  (- x 1))

(define (partial fn . args)
  (lambda rest-args
    (apply fn (append args rest-args))
    ))
