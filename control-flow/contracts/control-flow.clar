
;; the asserts input must return true for the function to hit ok
;; if asserts is false, the function stops execution
(define-public (asserts-example (input bool)) 
  (begin 
    (asserts! input (err "the assertion failed"))
    (ok "end of function")
  )
)
;; (contract-call? .control-flow asserts-example true)


;; try will attempt to unwrap (or extract the value from) input which is a response type of an uint and we'll pass it a uint
;; if successful we hit ok
;; if fails we stop execution
(define-public (try-example (input (response uint uint)))
  (begin
    (try! input)
    (ok "end of function")
  )
)
;;(contract-call? .control-flow try-example (ok u1))

;; If it receives an err, it returns that err and exits. It does not unwrap the value inside!
;;(contract-call? .control-flow try-example (err u2))


;; similar to try! But instead of returning none or the error, it will return the throw value
(define-public (unwrap-example (input (response uint uint)))
  (begin
    (unwrap! input (err "unwrap failed"))
    (ok "end of function")
  )
)

;;(contract-call? .control-flow unwrap-example (err u1))
;; (contract-call? .control-flow unwrap-example (ok u1))

;; 
;;if it fails to unwrap it throws a runtime error and exits
(define-public (unwrap-panic-example (input (optional uint)))
  (begin
    (unwrap-panic input)
    (ok "end of function")
  )
)

;;(contract-call? .control-flow unwrap-panic-example (some u1))
;;(contract-call? .control-flow unwrap-panic-example none) 
;; this will result in an exit without information and is why typically it's not a good idea to use panic


;; TODO
;;unwrap-err
;;unwrap-err-panic
